/// Contains information about the condition.
pub const FilterCondition = struct {
    /// Represents an *equal*
    /// **** condition to be applied to
    /// a single field when querying for scan entries.
    equals_value: ?[]const u8 = null,

    /// Represents a *greater than* condition to be applied to a single field
    /// when querying for scan entries.
    greater_than: ?i64 = null,

    /// Represents a *less than* condition to be applied to a single field when
    /// querying for scan entries.
    less_than: ?i64 = null,

    pub const json_field_names = .{
        .equals_value = "EqualsValue",
        .greater_than = "GreaterThan",
        .less_than = "LessThan",
    };
};
