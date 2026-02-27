/// Parameters to derive session key value using a MAC EMV algorithm.
pub const SessionKeyDerivationValue = union(enum) {
    /// The cryptogram provided by the terminal during transaction processing.
    application_cryptogram: ?[]const u8,
    /// The transaction counter that is provided by the terminal during transaction
    /// processing.
    application_transaction_counter: ?[]const u8,

    pub const json_field_names = .{
        .application_cryptogram = "ApplicationCryptogram",
        .application_transaction_counter = "ApplicationTransactionCounter",
    };
};
