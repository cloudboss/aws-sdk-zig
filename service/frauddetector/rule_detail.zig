const Language = @import("language.zig").Language;

/// The details of the rule.
pub const RuleDetail = struct {
    /// The rule ARN.
    arn: ?[]const u8 = null,

    /// The timestamp of when the rule was created.
    created_time: ?[]const u8 = null,

    /// The rule description.
    description: ?[]const u8 = null,

    /// The detector for which the rule is associated.
    detector_id: ?[]const u8 = null,

    /// The rule expression.
    expression: ?[]const u8 = null,

    /// The rule language.
    language: ?Language = null,

    /// Timestamp of the last time the rule was updated.
    last_updated_time: ?[]const u8 = null,

    /// The rule outcomes.
    outcomes: ?[]const []const u8 = null,

    /// The rule ID.
    rule_id: ?[]const u8 = null,

    /// The rule version.
    rule_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .detector_id = "detectorId",
        .expression = "expression",
        .language = "language",
        .last_updated_time = "lastUpdatedTime",
        .outcomes = "outcomes",
        .rule_id = "ruleId",
        .rule_version = "ruleVersion",
    };
};
