const ConfirmationStatus = @import("confirmation_status.zig").ConfirmationStatus;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const QueryNetwork = @import("query_network.zig").QueryNetwork;

/// There are two possible types of transactions used for this data type:
///
/// * A Bitcoin transaction is a movement of BTC from one address to
/// another.
///
/// * An Ethereum transaction refers to an action initiated by an externally
/// owned account, which is an account managed by a human, not a contract.
/// For example, if Bob sends Alice 1 ETH, Bob's account must be debited and
/// Alice's must be credited. This state-changing action occurs within a
/// transaction.
pub const Transaction = struct {
    /// The block hash is a unique identifier for a block. It is a fixed-size
    /// string that is calculated by using the information in the block. The block
    /// hash is used to verify the integrity of the data in the block.
    block_hash: ?[]const u8 = null,

    /// The block number in which the transaction is recorded.
    block_number: ?[]const u8 = null,

    /// Specifies whether the transaction has reached Finality.
    confirmation_status: ?ConfirmationStatus = null,

    /// The blockchain address for the contract.
    contract_address: ?[]const u8 = null,

    /// The amount of gas used up to the specified point in the block.
    cumulative_gas_used: ?[]const u8 = null,

    /// The effective gas price.
    effective_gas_price: ?[]const u8 = null,

    /// Identifies whether the transaction has succeeded or failed.
    execution_status: ?ExecutionStatus = null,

    /// The initiator of the transaction. It is either in the form a public key or a
    /// contract address.
    from: ?[]const u8 = null,

    /// The amount of gas used for the transaction.
    gas_used: ?[]const u8 = null,

    /// The blockchain network where the transaction occurred.
    network: QueryNetwork,

    /// The number of transactions in the block.
    number_of_transactions: i64,

    /// The signature of the transaction. The X coordinate of a point R.
    signature_r: ?[]const u8 = null,

    /// The signature of the transaction. The Y coordinate of a point S.
    signature_s: ?[]const u8 = null,

    /// The signature of the transaction. The Z coordinate of a point V.
    signature_v: ?i32 = null,

    /// The identifier of the transaction. It is generated whenever a transaction is
    /// verified and added to the blockchain.
    to: []const u8,

    /// The transaction fee.
    transaction_fee: ?[]const u8 = null,

    /// The hash of a transaction. It is generated when a transaction is created.
    transaction_hash: []const u8,

    /// The identifier of a Bitcoin transaction. It is generated when a transaction
    /// is created.
    transaction_id: ?[]const u8 = null,

    /// The index of the transaction within a blockchain.
    transaction_index: i64,

    /// The `Timestamp` of the transaction.
    transaction_timestamp: i64,

    pub const json_field_names = .{
        .block_hash = "blockHash",
        .block_number = "blockNumber",
        .confirmation_status = "confirmationStatus",
        .contract_address = "contractAddress",
        .cumulative_gas_used = "cumulativeGasUsed",
        .effective_gas_price = "effectiveGasPrice",
        .execution_status = "executionStatus",
        .from = "from",
        .gas_used = "gasUsed",
        .network = "network",
        .number_of_transactions = "numberOfTransactions",
        .signature_r = "signatureR",
        .signature_s = "signatureS",
        .signature_v = "signatureV",
        .to = "to",
        .transaction_fee = "transactionFee",
        .transaction_hash = "transactionHash",
        .transaction_id = "transactionId",
        .transaction_index = "transactionIndex",
        .transaction_timestamp = "transactionTimestamp",
    };
};
