const InstanceInterruptionBehavior = @import("instance_interruption_behavior.zig").InstanceInterruptionBehavior;
const SpotInstanceType = @import("spot_instance_type.zig").SpotInstanceType;

/// The options for Spot Instances.
pub const LaunchTemplateSpotMarketOptions = struct {
    /// The required duration for the Spot Instances (also known as Spot blocks), in
    /// minutes.
    /// This value must be a multiple of 60 (60, 120, 180, 240, 300, or 360).
    block_duration_minutes: ?i32,

    /// The behavior when a Spot Instance is interrupted.
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
    max_price: ?[]const u8,

    /// The Spot Instance request type.
    spot_instance_type: ?SpotInstanceType,

    /// The end date of the request. For a one-time request, the request remains
    /// active until
    /// all instances launch, the request is canceled, or this date is reached. If
    /// the request
    /// is persistent, it remains active until it is canceled or this date and time
    /// is
    /// reached.
    valid_until: ?i64,
};
