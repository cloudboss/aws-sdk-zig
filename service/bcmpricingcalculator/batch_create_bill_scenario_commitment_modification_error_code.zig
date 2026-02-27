pub const BatchCreateBillScenarioCommitmentModificationErrorCode = enum {
    conflict,
    internal_server_error,
    invalid_account,

    pub const json_field_names = .{
        .conflict = "CONFLICT",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
        .invalid_account = "INVALID_ACCOUNT",
    };
};
