pub const EnablementStatus = enum {
    succeeded,
    failed,
    under_change,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .under_change = "UNDER_CHANGE",
    };
};
