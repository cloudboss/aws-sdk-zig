/// Details about the account that was not processed.
pub const Result = struct {
    /// An Amazon Web Services account ID of the account that was not processed.
    account_id: ?[]const u8 = null,

    /// The reason that the account was not processed.
    processing_result: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .processing_result = "ProcessingResult",
    };
};
