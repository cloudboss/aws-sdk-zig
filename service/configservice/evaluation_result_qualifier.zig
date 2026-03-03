const EvaluationMode = @import("evaluation_mode.zig").EvaluationMode;

/// Identifies an Config rule that evaluated an Amazon Web Services resource,
/// and provides the type and ID of the resource that the rule
/// evaluated.
pub const EvaluationResultQualifier = struct {
    /// The name of the Config rule that was used in the
    /// evaluation.
    config_rule_name: ?[]const u8 = null,

    /// The mode of an evaluation. The valid values are Detective or Proactive.
    evaluation_mode: ?EvaluationMode = null,

    /// The ID of the evaluated Amazon Web Services resource.
    resource_id: ?[]const u8 = null,

    /// The type of Amazon Web Services resource that was evaluated.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .config_rule_name = "ConfigRuleName",
        .evaluation_mode = "EvaluationMode",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
