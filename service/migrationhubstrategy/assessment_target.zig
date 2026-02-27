const Condition = @import("condition.zig").Condition;

/// Defines the criteria of assessment.
pub const AssessmentTarget = struct {
    /// Condition of an assessment.
    condition: Condition,

    /// Name of an assessment.
    name: []const u8,

    /// Values of an assessment.
    values: []const []const u8,

    pub const json_field_names = .{
        .condition = "condition",
        .name = "name",
        .values = "values",
    };
};
