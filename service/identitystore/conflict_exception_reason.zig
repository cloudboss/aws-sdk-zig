pub const ConflictExceptionReason = enum {
    uniqueness_constraint_violation,
    concurrent_modification,

    pub const json_field_names = .{
        .uniqueness_constraint_violation = "UNIQUENESS_CONSTRAINT_VIOLATION",
        .concurrent_modification = "CONCURRENT_MODIFICATION",
    };
};
