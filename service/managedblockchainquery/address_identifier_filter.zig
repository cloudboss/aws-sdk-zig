/// This is the container for the unique public address on the blockchain.
pub const AddressIdentifierFilter = struct {
    /// The container for the recipient address of the transaction.
    transaction_event_to_address: []const []const u8,

    pub const json_field_names = .{
        .transaction_event_to_address = "transactionEventToAddress",
    };
};
