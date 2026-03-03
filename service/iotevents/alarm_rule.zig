const SimpleRule = @import("simple_rule.zig").SimpleRule;

/// Defines when your alarm is invoked.
pub const AlarmRule = struct {
    /// A rule that compares an input property value to a threshold value with a
    /// comparison operator.
    simple_rule: ?SimpleRule = null,

    pub const json_field_names = .{
        .simple_rule = "simpleRule",
    };
};
