const VariableValue = @import("variable_value.zig").VariableValue;

/// This structure displays the results of one feature evaluation assignment to
/// one user session.
pub const EvaluationResult = struct {
    /// If this user was assigned to a launch or experiment, this field lists the
    /// launch or experiment name.
    details: ?[]const u8 = null,

    /// An internal ID that represents a unique user session of the application.
    entity_id: []const u8,

    /// The name of the feature being evaluated.
    feature: []const u8,

    /// The name or ARN of the project that contains the feature being evaluated.
    project: ?[]const u8 = null,

    /// Specifies the reason that the user session was assigned this variation.
    /// Possible values include `DEFAULT`, meaning the user was served the default
    /// variation; `LAUNCH_RULE_MATCH`, if the user session was enrolled in a
    /// launch; or `EXPERIMENT_RULE_MATCH`, if the user session was enrolled in an
    /// experiment.
    reason: ?[]const u8 = null,

    /// The value assigned to this variation to differentiate it from the other
    /// variations of this feature.
    value: ?VariableValue = null,

    /// The name of the variation that was served to the user session.
    variation: ?[]const u8 = null,

    pub const json_field_names = .{
        .details = "details",
        .entity_id = "entityId",
        .feature = "feature",
        .project = "project",
        .reason = "reason",
        .value = "value",
        .variation = "variation",
    };
};
