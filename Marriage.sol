// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Marriage{
    uint i;

    struct marriage{
        address parte1;
        bool aceite_parte1;
        address parte2;
        bool aceite_parte2;
        bool oficializado;
    }

    marriage[] private marriages;

    function aceitar() public{
        for (i = 0; i < marriages.length; i++) 
        {   
            if (marriages[i].oficializado == true){
                return;
            }
            if (msg.sender == marriages[i].parte1){
                marriages[i].aceite_parte1 = true;
                return;
            }
            if (msg.sender == marriages[i].parte2){
                marriages[i].aceite_parte2 = true;
                return;
            }
        }
    }

    function submit_casamento(address parte1, address parte2) private{
        marriage memory new_marriage = marriage(parte1, false, parte2, false, false);
        marriages.push(new_marriage);
    }

    function oficializar(address parte1, address parte2) private{
        for (i = 0; i < marriages.length; i++)
        {
            if (marriages[i].parte1 == parte1 && marriages[i].parte2 == parte2){

             if (marriages[i].aceite_parte1 == true && marriages[i].aceite_parte2 == true){
                    marriages[i].oficializado = true;
                    return;
             }

            }
        }
    }
}
