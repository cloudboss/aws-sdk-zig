/// Operators for Connect instance identifier filter
pub const InstanceIdFilterOperator = enum {
    /// Equals operator
    eq,

    pub const json_field_names = .{
        .eq = "EQ",
    };
};
