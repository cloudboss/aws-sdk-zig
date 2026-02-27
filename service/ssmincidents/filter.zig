const Condition = @import("condition.zig").Condition;

/// Filter the selection by using a condition.
pub const Filter = struct {
    /// The condition accepts before or after a specified time, equal to a string,
    /// or equal to an
    /// integer.
    condition: Condition,

    /// The key that you're filtering on.
    key: []const u8,

    pub const json_field_names = .{
        .condition = "condition",
        .key = "key",
    };
};
