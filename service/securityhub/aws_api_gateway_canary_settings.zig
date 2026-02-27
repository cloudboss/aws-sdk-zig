const aws = @import("aws");

/// Contains information about settings for canary deployment in the stage.
pub const AwsApiGatewayCanarySettings = struct {
    /// The deployment identifier for the canary deployment.
    deployment_id: ?[]const u8,

    /// The percentage of traffic that is diverted to a canary deployment.
    percent_traffic: ?f64,

    /// Stage variables that are overridden in the canary release deployment. The
    /// variables
    /// include new stage variables that are introduced in the canary.
    ///
    /// Each variable is represented as a string-to-string map between the stage
    /// variable name
    /// and the variable value.
    stage_variable_overrides: ?[]const aws.map.StringMapEntry,

    /// Indicates whether the canary deployment uses the stage cache.
    use_stage_cache: ?bool,

    pub const json_field_names = .{
        .deployment_id = "DeploymentId",
        .percent_traffic = "PercentTraffic",
        .stage_variable_overrides = "StageVariableOverrides",
        .use_stage_cache = "UseStageCache",
    };
};
