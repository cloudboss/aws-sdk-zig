const aws = @import("aws");

/// Configuration settings of a canary deployment.
pub const CanarySettings = struct {
    /// The ID of the canary deployment.
    deployment_id: ?[]const u8 = null,

    /// The percent (0-100) of traffic diverted to a canary deployment.
    percent_traffic: f64 = 0,

    /// Stage variables overridden for a canary release deployment, including new
    /// stage variables introduced in the canary. These stage variables are
    /// represented as a string-to-string map between stage variable names and their
    /// values.
    stage_variable_overrides: ?[]const aws.map.StringMapEntry = null,

    /// A Boolean flag to indicate whether the canary deployment uses the stage
    /// cache or not.
    use_stage_cache: bool = false,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .percent_traffic = "percentTraffic",
        .stage_variable_overrides = "stageVariableOverrides",
        .use_stage_cache = "useStageCache",
    };
};
