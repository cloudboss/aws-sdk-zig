const BlockchainInstant = @import("blockchain_instant.zig").BlockchainInstant;
const ConfirmationStatus = @import("confirmation_status.zig").ConfirmationStatus;
const QueryTransactionEventType = @import("query_transaction_event_type.zig").QueryTransactionEventType;
const QueryNetwork = @import("query_network.zig").QueryNetwork;

/// The container for the properties of a transaction event.
pub const TransactionEvent = struct {
    blockchain_instant: ?BlockchainInstant,

    /// This container specifies whether the transaction has reached Finality.
    confirmation_status: ?ConfirmationStatus,

    /// The blockchain address for the contract
    contract_address: ?[]const u8,

    /// The type of transaction event.
    event_type: QueryTransactionEventType,

    /// The wallet address initiating the transaction. It can either be a public key
    /// or a contract.
    from: ?[]const u8,

    /// The blockchain network where the transaction occurred.
    network: QueryNetwork,

    /// The position of the spent transaction output in the output list of the
    /// *creating transaction*.
    ///
    /// This is only returned for `BITCOIN_VIN` event types.
    spent_vout_index: ?i32,

    /// The transactionHash that *created* the spent transaction output.
    ///
    /// This is only returned for `BITCOIN_VIN` event types.
    spent_vout_transaction_hash: ?[]const u8,

    /// The transactionId that *created* the spent transaction output.
    ///
    /// This is only returned for `BITCOIN_VIN` event types.
    spent_vout_transaction_id: ?[]const u8,

    /// The wallet address receiving the transaction. It can either be a public key
    /// or a contract.
    to: ?[]const u8,

    /// The unique identifier for the token involved in the transaction.
    token_id: ?[]const u8,

    /// The hash of a transaction. It is generated when a transaction is created.
    transaction_hash: []const u8,

    /// The identifier of a Bitcoin transaction. It is generated when a transaction
    /// is created.
    transaction_id: ?[]const u8,

    /// The value that was transacted.
    value: ?[]const u8,

    /// The position of the transaction output in the transaction output list.
    vout_index: ?i32,

    /// Specifies if the transaction output is spent or unspent. This is only
    /// returned for BITCOIN_VOUT event types.
    ///
    /// This is only returned for `BITCOIN_VOUT` event types.
    vout_spent: ?bool,

    pub const json_field_names = .{
        .blockchain_instant = "blockchainInstant",
        .confirmation_status = "confirmationStatus",
        .contract_address = "contractAddress",
        .event_type = "eventType",
        .from = "from",
        .network = "network",
        .spent_vout_index = "spentVoutIndex",
        .spent_vout_transaction_hash = "spentVoutTransactionHash",
        .spent_vout_transaction_id = "spentVoutTransactionId",
        .to = "to",
        .token_id = "tokenId",
        .transaction_hash = "transactionHash",
        .transaction_id = "transactionId",
        .value = "value",
        .vout_index = "voutIndex",
        .vout_spent = "voutSpent",
    };
};
