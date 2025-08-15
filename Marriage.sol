// SPDX-License-Identifier: GPL-3.0

pragma solidity <=0.7.0 >0.9.0;

contract Marriage{
    address public owner;
    
    uint256 next_marriage = 1;

    struct marriage{
        uint256 marriageId;
        bool oficializado;
        address parte1;
        address parte2;
        mapping (address => bool) aceite;
        bool divorciado_anulado;
    }

    mapping(uint256 => marriage) public marriages;

    mapping(address => uint256) public casamento_ativo;

    constructor() {
        owner = msg.sender;
    }

    function submit_casamento(address parte1, address parte2) public{
        require(msg.sender == owner, "Somente o owner do contrato pode fazer essa chamada");
        require(casamento_ativo[parte1] == 0, "someone is already married");
        require(casamento_ativo[parte2] == 0, "someone is already married");
        
        uint256 currentMarriageId = next_marriage;
        marriage storage tmp_marriage = marriages[currentMarriageId];
        tmp_marriage.marriageId = currentMarriageId;
        tmp_marriage.parte1 = parte1;
        tmp_marriage.parte2 = parte2;
        casamento_ativo[parte1] = currentMarriageId;
        casamento_ativo[parte2] = currentMarriageId;
        next_marriage = next_marriage + 1;
    }

    function aceitar() public{
        uint256 marriageId = casamento_ativo[msg.sender];
        require(marriageId > 0, "No active marriage for this address");
        marriage storage tmp_marriage = marriages[marriageId];
        tmp_marriage.aceite[msg.sender] = true;
    }

    function oficializar(uint256 marriageId) private{
        require(msg.sender == owner, "Only the owner can call this function");
        require(marriages[marriageId].oficializado == false, "Marriage already officialized");
        require(marriages[marriageId].divorciado_anulado == false, "Marriage already ended, nothing to officialize");
        marriages[marriageId].oficializado = true;
    }
}
