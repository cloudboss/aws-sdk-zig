const aws = @import("aws");

/// The input configuration for a canary deployment.
pub const DeploymentCanarySettings = struct {
    /// The percentage (0.0-100.0) of traffic routed to the canary deployment.
    percent_traffic: f64 = 0,

    /// A stage variable overrides used for the canary release deployment. They can
    /// override existing stage variables or add new stage variables for the canary
    /// release deployment. These stage variables are represented as a
    /// string-to-string map between stage variable names and their values.
    stage_variable_overrides: ?[]const aws.map.StringMapEntry,

    /// A Boolean flag to indicate whether the canary release deployment uses the
    /// stage cache or not.
    use_stage_cache: bool = false,

    pub const json_field_names = .{
        .percent_traffic = "percentTraffic",
        .stage_variable_overrides = "stageVariableOverrides",
        .use_stage_cache = "useStageCache",
    };
};
