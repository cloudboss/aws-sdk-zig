const Condition = @import("condition.zig").Condition;
const Logical = @import("logical.zig").Logical;

/// Defines the predicate of the trigger, which determines when it fires.
pub const Predicate = struct {
    /// A list of the conditions that determine when the trigger will fire.
    conditions: ?[]const Condition = null,

    /// An optional field if only one condition is listed. If multiple conditions
    /// are listed, then
    /// this field is required.
    logical: ?Logical = null,

    pub const json_field_names = .{
        .conditions = "Conditions",
        .logical = "Logical",
    };
};
