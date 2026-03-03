const ConfirmationStatus = @import("confirmation_status.zig").ConfirmationStatus;
const QueryNetwork = @import("query_network.zig").QueryNetwork;

/// The container of the transaction output.
pub const TransactionOutputItem = struct {
    /// Specifies whether to list transactions that have not reached Finality.
    confirmation_status: ?ConfirmationStatus = null,

    /// The blockchain network where the transaction occurred.
    network: QueryNetwork,

    /// The hash of a transaction. It is generated when a transaction is created.
    transaction_hash: []const u8,

    /// The identifier of a Bitcoin transaction. It is generated when a transaction
    /// is created.
    transaction_id: ?[]const u8 = null,

    /// The time when the transaction occurred.
    transaction_timestamp: i64,

    pub const json_field_names = .{
        .confirmation_status = "confirmationStatus",
        .network = "network",
        .transaction_hash = "transactionHash",
        .transaction_id = "transactionId",
        .transaction_timestamp = "transactionTimestamp",
    };
};
