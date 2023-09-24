program betrayal.aleo {


    mapping events: u8 => u8;
    mapping hauntings: u8 => u8;




    // Betrayal at Astor Mansion boards are represented by 128-bit, unsigned integers. The board
    // contains 50 rooms, connected to a 50 cell wide hallroom.
    // cell_state: represents whether or not a given cell is occupied or not: (100 cell, max 128 cells)
    //   - cell_state = 0 -> free
    //   - cell_state = 1 -> occupied
    // cell_occ: represents who is the occupant: (max 8 players)
    //   - cell_occ = 0 -> player 1
    //   - cell_occ = 1 -> player 2
    //   - cell_occ = 1 -> player 2

// signed integers for power, sanity, knowledge change:
// 11111111 11111111 11111111 11111110 = -2
// 11111111 11111111 11111111 11111111 = -1
// 00000000 00000000 00000000 00000000 = 0 
// 00000000 00000000 00000000 00000001 = 1
// 00000000 00000000 00000000 00000010 = 2
  record Dice {
        owner: address,
        gates: u64,
        match_id: field,
        dice_amount: u32
    }
    
    
    record Board {
        owner: address,
        gates: u64,
        cell_state: u128,
        cell_occ: u8,
        p1: address,
        p2: address
        p3: address
        p4: address
        p5: address
        p6: address
        p7: address
        p8: address
     }

  struct Players {
        p1: PlayerInfo,
        p2: PlayerInfo,
        p3: PlayerInfo,
        p4: PlayerInfo,
        p5: PlayerInfo,
        p6: PlayerInfo,
        p7: PlayerInfo,
        p8: PlayerInfo
     }





    record PlayerInfo {
        owner: address,
        gates: u64,
        position: u128
        sanity: u16
        power: u16
        knowledge: u16
    }

    // This struct allows us to pass the state and occupant of a cell
    // with a single variable.
    struct Cells {
        state: u32,
        occupants: u32,
    }

    // Auxiliary function that returns true if i-th bit of 'number' is '1'
    inline get_bit(number: u32, i: u8) -> bool {
        let mask: u32 = 1u32 << i-1u8;
        return number.and(mask) > 0u32;
    }

    // Auxiliary function that sets the i-th bit of 'number' to 'bit'
    inline set_bit(number: u32, i: u8, bit: bool) -> u32{
        let mask: u32 = 1u32 << i-1u8;
        if bit {
            return number.or(mask);
        } else {
            return number.and(mask.not());
        }
    }

    // Function to get the occupant of the i-th cell according to the following convention:
    // i-th cell is empty: returns 0u8
    // i-th cell is occupied by player 1: returns 1u8  00000001
    // i-th cell is occupied by player 1 & 2: returns 3u8  00000011
    // i-th cell is occupied by player 1 & 2 & 3: returns 7u8  00000111
    // i-th cell is occupied by player 3: returns 4u8  00000100
    inline get_cell_occupants(cells: Cells, i: u8) -> u8 {
        let is_occupied: bool = get_bit(cells.state, i);
        if is_occupied {
            return get_bit(cells.occupants, i) ? 2u8 : 1u8;
        } else {
            return 0u8;
        }
    }

    // Function to set the occupant of a cell. Takes care of setting both the 'state' and
    // 'occupant' fields accordingly.
    inline set_cell_occupant(cells: Cells, cell: u8, occ: u8) -> Cells {
        // if occ==1u8 (player1) then bit=0, if occ==2u8 (player2) then bit=1;
        let bit: bool = occ == 2u8;
        return Cells {
            state: set_bit(cells.state, cell, true), // the cell is now occupied by a player, thus state = 1
            occupant: set_bit(cells.occupants, cell, bit),
        };
    }

    // Function to clear a cell.
    inline clear_cell(cells: Cells, cell: u8) -> Cells {
        return Cells {
            state: set_bit(cells.state, cell, false),
            occupant: set_bit(cells.occupant, cell, false),
        };
    }

    transition get_cell_type(i: u8) -> u8 {
      return then finalize(i);

    }


    finalize get_cell_type(i: u8) {

      // DEFINE ROOMS
        if (i>50u8){
            let currentRoom:u8 = i-50u8;
            return Mapping::get_or_use(events, currentRoom, 0u64)
        }else{
            return 0u8;
        }
    }


    // Used to get the opponent's address
    function get_opponent(board: Board) -> address {
        if board.owner == board.p1 {
            return board.p2;
        } else {
            return board.p1;
        }
    }

    // Returns true if the piece that the current player chose to move
    // in fact belongs to the current player.
    function piece_is_valid(origin_cell: u8, owner: address, p1: address, p2: address, cells: Cells) -> bool {
        let player: u8 = get_cell_occupants(cells, origin_cell);
        if player == 1u8 {
            return owner == p1;
        } else if player == 2u8 {
            return owner == p2;
        } else {
            return false;
        }
    }

    // In Betrayal at Astor Mansion, if you meet in a specific cell, your sanity goes up by 1

    function meet_party(cells: Cells, cell: u8) -> bool {

        // If the cell is empty, it means there is no one, so no sanity up
        let occ: u8 = get_cell_occupants(cells, cell);
        if occ == 0u8 {
            return false;
        }else{
            return true;
        }
     
    }

    // This function moves a piece from one cell to another.
    function move_piece(cells: Cells, origin_cell: u8, target_cell: u8) -> Cells {
        let occ: u8 = get_cell_occupants(cells, origin_cell);
        cells = set_cell_occupant(cells, target_cell, occ);
        cells = clear_cell(cells, origin_cell);
        return cells;
    }

    // This function exchanges the positions of two pieces.
    function exchange_pieces(cells: Cells, origin_cell: u8, target_cell: u8) -> Cells {
        let origin_cell_occ: u8 = get_cell_occupants(cells, origin_cell);
        let target_cell_occ: u8 = get_cell_occupants(cells, target_cell);
        cells = set_cell_occupant(cells, origin_cell, target_cell_occ);
        cells = set_cell_occupant(cells, target_cell, origin_cell_occ);
        return cells;
     }



    // Creates a new Board record and sets the owner to the caller, which from
    // now on will be known as player 1. 
    // The initial position of the pieces is as follows, where '0' means empty, '1'
    // means player 1 and '2' means player 2:
    // 
    // | 1 | 2 | 1 | 2 | 1 | 2 | 1 | 2 | 1 | 2 |
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 
    // 
    // The corresponding values of 'cell_state' and 'cell_occ' are
    //
    //   - cell_state:
    //
    //  LSB
    //   |
    //   v
    // | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 |
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |    =   1010101010b = 682
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    //                                       ^
    //                                       |
    //                                      MSB
    //
    //   - cell_occ:
    //
    // | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |    =   1111111111b = 1023
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    // 
    transition new(
        opponent1: address,
        opponent2: address,
        opponent3: address,
        opponent4: address,
        opponent5: address,
        opponent6: address,
        opponent7: address,
        opponent8: address,
        playerCount: u8 
    ) -> (Board, PlayerInfo) {

        let p1_address: address = opponent1;
        let p2_address: address = opponent2;
        let p3_address: address = opponent3;
        let p4_address: address = opponent4;
        let p5_address: address = opponent5;
        let p6_address: address = opponent6;
        let p7_address: address = opponent7;
        let p8_address: address = opponent8;

/*
 for i: u8 in 0u8..7u8 {
return according to players
  }
*/

        return (Board {
            owner: self.caller,
            gates: 0u64,
            cell_state: 1023u128, // 00000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000001 -> All players are at the start
            cell_occ: 682u16, // 00 0000000000 0000000000 0011111111 -> there are 8 players
            p1: self.caller,
            p2: p2_address,
            p3: p3_address,
            p4: p4_address,
            p5: p5_address,
            p6: p6_address,
            p7: p7_address,
            p8: p8_address,
        },

     PlayerInfo {
        owner:  self.caller,
        gates: u64,
        position: u128
        sanity: 10u16
        power: 10u16
        knowledge: 10u16
    },
);
    }

    transition rollDice(owner: address, public match_id: field) -> Dice {
        return Dice {
            owner: owner,
            gates: 0u64,
            match_id: match_id,
            dice_amount: dice_amount
        };
    }



    transition changePlayerStats(
        origin_cell: u8, 
        dice: u8, 
        board: Board, 
        playerInfo: PlayerInfo
    ) -> (Board, PlayerInfo) {


    }


    // This function is used to execute a move. 
    //   - Board: the current state of the board as generated by the last player to play
    //
    // Returns
    //   - Board: the board after executing the move. If the move was invalid, the board
    //                     will remain the same. The owner of this record is the player whose turn is next 
    //
    transition move(
        origin_cell: u8, 
        dice: u8, 
        board: Board, 
        playerInfo: PlayerInfo
    ) -> (Board, PlayerInfo) {
        // Validates that the board coming from the opponent is consistent
        assert (validate_board(board, playerInfo));
        
      
        // Validates that the origin cell contains a piece that belongs to the current player.
        assert(piece_is_valid(origin_cell, board.owner, board.p1, board.p2, cells));

        // Validates that the dice result is valid according to the rules of the game.
        assert(1u8 <= dice && dice <= 5u8);
        
        // Validates that the origin cell is not empty
        let player: u8 = get_cell_occupants(cells, origin_cell);
        assert(player == 1u8 || player == 2u8);

        // Validates that the target cell doesn't contain a piece from current player
        let target_cell: u8 = origin_cell + dice;
        let target_cell_occupants: u8 = get_cell_occupant(cells, target_cell);
        assert(target_cell_occupant != player);

        // Validates that either the target cell is empty or it contains
        // an unprotected piece from the opponent.
        let target_empty: bool = target_cell_occupant == 0u8; 
        let metparty: bool = meet_party(cells, target_cell);
        sanity_up(target_cell_occupants);


//        let valid_move: bool = !target_empty && !metparty || target_empty && !metparty;
        //assert( valid_move );
        
        // If the target cell is empty, then the current player's piece is moved to
        // the target cell. If the target cell is not empty (it contains an
        // unprotected opponent's piece) it exchanges the pieces.
        if target_empty {  // If target cell is empty
            cells = move_piece(cells, origin_cell, target_cell);
        } else {
            cells = exchange_pieces(cells, origin_cell, target_cell);
     
        // By default, the next player is the current player.
        let next_player: address = board.owner;

        return ( Board {
                        owner: next_player,
                        gates: board.gates,
                        cell_state: cells.state,
                        cell_occ: cells.occupant,
                        p1: board.p1,
                        p2: board.p2
                    },
                    PlayerInfo {
                            owner: address,
                            gates: u64,
                            position: u128
                            sanity: u16
                            power: u16
                            knowledge: u16
                    }
                );
    }

}