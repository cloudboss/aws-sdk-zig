pub const ConflictExceptionReason = enum {
    concurrent_modification,

    pub const json_field_names = .{
        .concurrent_modification = "CONCURRENT_MODIFICATION",
    };
};
