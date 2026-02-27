pub const BatchEntryCompletionStatus = enum {
    success,
    @"error",

    pub const json_field_names = .{
        .success = "SUCCESS",
        .@"error" = "ERROR",
    };
};
