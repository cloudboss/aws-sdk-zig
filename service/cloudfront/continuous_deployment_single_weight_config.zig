const SessionStickinessConfig = @import("session_stickiness_config.zig").SessionStickinessConfig;

/// Contains the percentage of traffic to send to a staging distribution.
pub const ContinuousDeploymentSingleWeightConfig = struct {
    session_stickiness_config: ?SessionStickinessConfig,

    /// The percentage of traffic to send to a staging distribution, expressed as a
    /// decimal number between 0 and 0.15. For example, a value of 0.10 means 10% of
    /// traffic is sent to the staging distribution.
    weight: f32,
};
