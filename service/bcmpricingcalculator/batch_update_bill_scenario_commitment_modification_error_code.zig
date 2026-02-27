pub const BatchUpdateBillScenarioCommitmentModificationErrorCode = enum {
    bad_request,
    not_found,
    conflict,
    internal_server_error,

    pub const json_field_names = .{
        .bad_request = "BAD_REQUEST",
        .not_found = "NOT_FOUND",
        .conflict = "CONFLICT",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };
};
