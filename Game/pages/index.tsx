import Image from 'next/image'
import { Inter } from 'next/font/google'

import React, { useState, useEffect, useCallback, FC, useMemo,useRef } from "react";
import { Unity, useUnityContext } from "react-unity-webgl";
import {useDevicePixelRatio} from 'use-device-pixel-ratio'

import { WalletProvider } from "@demox-labs/aleo-wallet-adapter-react";
import { WalletModalProvider, useWalletModal } from "@demox-labs/aleo-wallet-adapter-reactui";
import { LeoWalletAdapter } from "@demox-labs/aleo-wallet-adapter-leo";

import { useWallet } from "@demox-labs/aleo-wallet-adapter-react";

import {
  DecryptPermission,
  Transaction,
  WalletAdapterNetwork,
  WalletNotConnectedError,
  MessageSignerWalletAdapter
} from "@demox-labs/aleo-wallet-adapter-base";




require("@demox-labs/aleo-wallet-adapter-reactui/styles.css");


const inter = Inter({ subsets: ['latin'] })

export default function Home() {


  const { requestTransaction } = useWallet();


    
    const [isGameOver, setIsGameOver] = useState(false);
    const [userName, setUserName] = useState();
    const [move, setMove] = useState();
    const [wallet, setWallet] = useState<LeoWalletAdapter>();
    const [publicKey, setPublickey] = useState<String>();





    const dpr = useDevicePixelRatio()
    console.log("DPR___",dpr);





      const handleGameOver = (userName:string, score:number) => {
console.log("GAME_OVER")      
};

      const handleSetMove = async (position:number, move:number) => {
        console.log('GAME_EVENT / SETMOVE: ', position,move);
      





      };

      const handleConnectWallet = async () => {

        console.log("HANDLE_CONNECT_WALLET");
        console.log("_______CONNECTING TO WALLET_______");


        var wallet = new LeoWalletAdapter({ appName: 'BATAM'});


        wallet.connect(DecryptPermission.AutoDecrypt, WalletAdapterNetwork.Testnet).then(() => {
          let utf8Encode = new TextEncoder();
          let bytes = utf8Encode.encode("Leo & BATAM are awesome");
          wallet.signMessage(bytes);
          console.log('Signature: ', bytes);
          console.log('GAME_EVENT / PUBLICKEY: ', wallet.publicKey);
        });
        setPublickey(wallet.publicKey);
        setWallet(wallet);
      };



        

        function game_start(){
            console.log("_______START WALLET_______");
        }

        function game_run(){
            console.log("_______RUN WALLET_______");
        }
        function game_move(){
            console.log("_______MOVE WALLET_______");


            //leo run move 7u8 2u8
        }






  return (
<>

<div className="bg-black flex flex-col h-screen justify-center items-center">
<div className="w-1/3 flex align-right justify-end ">
<div className="bg-red-800 p-2 w-32 rounded-lg align-right justify-end">

  
 <button onClick={handleConnectWallet}> Connect Wallet</button></div>
  
  
  </div>

    <div className="bg-black p-2 w-full flex justify-center">
    <img src="/home.png"  className='mx-auto  rounded-2xl'/>
    </div>

  </div>


</>
  )
}

/*
<div className="w-full h-full">
<div></div>
</div>
*/