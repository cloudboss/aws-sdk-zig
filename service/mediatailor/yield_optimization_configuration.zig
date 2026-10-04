const ApsRegion = @import("aps_region.zig").ApsRegion;

/// Configuration for Yield Optimization, which fills unsold ad inventory in ad
/// breaks with programmatic ads from Amazon Publisher Services (APS).
pub const YieldOptimizationConfiguration = struct {
    /// The minimum unfilled duration, in seconds, that must remain in an ad break
    /// before MediaTailor requests additional ads from Amazon Publisher Services
    /// (APS). For example, if set to 6 seconds, yield optimization triggers only
    /// when at least 6 seconds of unfilled time remains after the primary ad server
    /// response.
    minimum_unfilled_duration: i32,

    /// The OpenRTB bid request template, in JSON, that MediaTailor sends to Amazon
    /// Publisher Services (APS). The template must include an `imp` array with one
    /// impression specifying `bidfloor`, an `app` object specifying `bundle` and
    /// `storeurl`, and a `device` object specifying `ua` and `ip`. Use double curly
    /// braces (for example, `{{player_params.user_agent}}`) to insert session
    /// variables and player parameters.
    open_rtb_template: []const u8,

    /// Publisher ID for an existing Amazon Publisher Services configuration. This
    /// ID must be obtained by registering with APS prior to using the Yield
    /// Optimization feature. The Publisher ID identifies your account in the APS
    /// system and is required for all bid requests.
    publisher_id: []const u8,

    /// The Amazon Publisher Services (APS) region that MediaTailor sends bid
    /// requests to. Choose the region closest to your primary audience, because the
    /// selection affects both latency and the ad inventory available to you. This
    /// setting applies to the entire playback configuration, not to individual
    /// viewers. If you serve traffic across multiple regions, create a separate
    /// playback configuration for each APS region.
    region: ApsRegion,

    pub const json_field_names = .{
        .minimum_unfilled_duration = "MinimumUnfilledDuration",
        .open_rtb_template = "OpenRtbTemplate",
        .publisher_id = "PublisherId",
        .region = "Region",
    };
};
