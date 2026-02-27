const ValidationMode = @import("validation_mode.zig").ValidationMode;

/// Configuration for data quality validation. Used to select the Rulesets and
/// Validation Mode
/// to be used in the profile job. When ValidationConfiguration is null, the
/// profile
/// job will run without data quality validation.
pub const ValidationConfiguration = struct {
    /// The Amazon Resource Name (ARN) for the ruleset to be validated in the
    /// profile job.
    /// The TargetArn of the selected ruleset should be the same as the Amazon
    /// Resource Name (ARN) of
    /// the dataset that is associated with the profile job.
    ruleset_arn: []const u8,

    /// Mode of data quality validation. Default mode is “CHECK_ALL” which verifies
    /// all rules
    /// defined in the selected ruleset.
    validation_mode: ?ValidationMode,

    pub const json_field_names = .{
        .ruleset_arn = "RulesetArn",
        .validation_mode = "ValidationMode",
    };
};
