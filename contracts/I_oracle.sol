// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Permission} from "./interfaces/permission.sol";

contract IOracle {


    uint internal CurrentReqID;

    event ReqState(uint reqID, address user, bool statement, string info);

    //contract owner
    address private owner;
    // A mapping of dbName to db owner`s addresses. dbName=>dbOwner address
    mapping(string => address) internal dbOwner;
    // A mapping of db owner`s addresses to db`s name. dbOwner address=>db`s name
    mapping(address=>string) internal myDbName;
    // Mapping from dbName to whether collection exists   db`s name=>collection name=>isExist
    mapping(string => mapping(string => bool)) internal cols;
    // A mapping of user address to db control permission.  address=>db`s name=>permission
    mapping(address => mapping(string => Permission)) internal permission;
    // A mapping of ReqID to request statement
    mapping(uint => bool) internal reqStatement;

    function GetReqState(uint ReqID) public view returns (bool){
        return reqStatement[ReqID];
    }

    constructor() {
        owner = msg.sender;
        CurrentReqID = 1;
    }

    modifier onlyOracleOwner() {
        require(msg.sender == owner, "Only the oracle owner can call this function");
        _;
    }
    modifier onlyDbOwner(string calldata dbName) {
        require(msg.sender == dbOwner[dbName], "Only the db owner can call this function");
        _;
    }
    modifier dbIsExsist(string calldata dbName) {
        require(dbOwner[dbName] != address(0), "Db is not exist");
        _;
    }
    modifier colIsExsist(string calldata dbName, string calldata colName) {
        require(cols[dbName][colName] != false, "This collection has not been created yet");
        _;
    }
    // modifier allowInsert(string calldata cid){
    //     require(permission[msg.sender][cid].allowInsert == true,"You do not have permission to insert");
    //     _;
    // }
    // modifier allowUpdate(string calldata cid){
    //     require(permission[msg.sender][cid].allowUpdate == true,"You do not have permission to update");
    //     _;
    // }
    modifier allowWrite(string calldata dbName){
        require(permission[msg.sender][dbName].allowWrite == true, "You do not have permission to write");
        _;
    }
    modifier allowQuery(string calldata dbName){
        require(permission[msg.sender][dbName].allowQuery == true, "You do not have permission to query");
        _;
    }
    modifier allowDelete(string calldata dbName){
        require(permission[msg.sender][dbName].allowDelete == true, "You do not have permission to delete");
        _;
    }

}