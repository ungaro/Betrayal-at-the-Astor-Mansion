program rng.aleo {
    record RandomNumberRecord {
        owner: address,
        gates: u64,
        random_number: u64
    }

    transition get_random_number(owner: address, min: u64, max: u64) -> RandomNumberRecord {
        
        let random_number: u64 = 0u64;

        return RandomNumberRecord {
            owner: owner,
            gates: 0u64,
            random_number: random_number
        } then finalize(random_number);
    }


    finalize get_random_number(random_number:u64) {

        
    random_number = ChaCha::rand_u64();

   

    }




}
