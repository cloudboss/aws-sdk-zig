pub const BatchDeleteBillScenarioCommitmentModificationErrorCode = enum {
    bad_request,
    conflict,
    internal_server_error,

    pub const json_field_names = .{
        .bad_request = "BAD_REQUEST",
        .conflict = "CONFLICT",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };
};
