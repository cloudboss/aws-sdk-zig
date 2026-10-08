/// A time-window condition that constrains when a support permit is valid.
pub const Condition = union(enum) {
    /// The earliest time at which the permit becomes valid.
    allow_after: ?i64,
    /// The latest time at which the permit remains valid.
    allow_before: ?i64,

    pub const json_field_names = .{
        .allow_after = "allowAfter",
        .allow_before = "allowBefore",
    };
};
