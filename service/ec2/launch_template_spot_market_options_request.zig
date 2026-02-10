const InstanceInterruptionBehavior = @import("instance_interruption_behavior.zig").InstanceInterruptionBehavior;
const SpotInstanceType = @import("spot_instance_type.zig").SpotInstanceType;

/// The options for Spot Instances.
pub const LaunchTemplateSpotMarketOptionsRequest = struct {
    /// Deprecated.
    block_duration_minutes: ?i32,

    /// The behavior when a Spot Instance is interrupted. The default is
    /// `terminate`.
    instance_interruption_behavior: ?InstanceInterruptionBehavior,

    /// The maximum hourly price you're willing to pay for a Spot Instance. We do
    /// not
    /// recommend using this parameter because it can lead to increased
    /// interruptions. If you do
    /// not specify this parameter, you will pay the current Spot price. If you do
    /// specify this
    /// parameter, it must be more than USD $0.001. Specifying a value below USD
    /// $0.001 will
    /// result in an `InvalidParameterValue` error message when the launch template
    /// is used to launch an instance.
    ///
    /// **Important:**
    ///
    /// If you specify a maximum price, your Spot Instances will be interrupted more
    /// frequently than if you do not specify this parameter.
    max_price: ?[]const u8,

    /// The Spot Instance request type.
    spot_instance_type: ?SpotInstanceType,

    /// The end date of the request, in UTC format
    /// (*YYYY-MM-DD*T*HH:MM:SS*Z). Supported only for
    /// persistent requests.
    ///
    /// * For a persistent request, the request remains active until the
    /// `ValidUntil` date and time is reached. Otherwise, the request
    /// remains active until you cancel it.
    ///
    /// * For a one-time request, `ValidUntil` is not supported. The request
    /// remains active until all instances launch or you cancel the request.
    ///
    /// Default: 7 days from the current date
    valid_until: ?i64,
};
