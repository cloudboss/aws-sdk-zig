const InstanceInterruptionBehavior = @import("instance_interruption_behavior.zig").InstanceInterruptionBehavior;
const SpotInstanceType = @import("spot_instance_type.zig").SpotInstanceType;

/// The options for Spot Instances.
pub const SpotMarketOptions = struct {
    /// Deprecated.
    block_duration_minutes: ?i32 = null,

    /// The behavior when a Spot Instance is interrupted.
    ///
    /// If `Configured` (for [
    /// `HibernationOptions`
    /// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_HibernationOptionsRequest.html)) is set to `true`, the
    /// `InstanceInterruptionBehavior` parameter is automatically set to
    /// `hibernate`. If you set it to `stop` or
    /// `terminate`, you'll get an error.
    ///
    /// If `Configured` (for [
    /// `HibernationOptions`
    /// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_HibernationOptionsRequest.html)) is set to `false` or
    /// `null`, the `InstanceInterruptionBehavior` parameter is
    /// automatically set to `terminate`. You can also set it to `stop` or
    /// `hibernate`.
    ///
    /// For more information, see [Interruption
    /// behavior](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/interruption-behavior.html) in the *Amazon EC2 User Guide*.
    instance_interruption_behavior: ?InstanceInterruptionBehavior = null,

    /// The maximum hourly price that you're willing to pay for a Spot Instance. We
    /// do not
    /// recommend using this parameter because it can lead to increased
    /// interruptions. If you do
    /// not specify this parameter, you will pay the current Spot price.
    ///
    /// If you specify a maximum price, your Spot Instances will be interrupted more
    /// frequently than if you do not specify this parameter.
    ///
    /// If you specify a maximum price, it must be more than USD $0.001. Specifying
    /// a value
    /// below USD $0.001 will result in an `InvalidParameterValue` error
    /// message.
    max_price: ?[]const u8 = null,

    /// The Spot Instance request type. For
    /// [RunInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances), persistent
    /// Spot Instance requests are only supported when the instance interruption
    /// behavior is
    /// either `hibernate` or `stop`.
    spot_instance_type: ?SpotInstanceType = null,

    /// The end date of the request, in UTC format
    /// (*YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    /// Supported only for persistent requests.
    ///
    /// * For a persistent request, the request remains active until the
    /// `ValidUntil` date and time is reached. Otherwise, the request
    /// remains active until you cancel it.
    ///
    /// * For a one-time request, `ValidUntil` is not supported. The request
    /// remains active until all instances launch or you cancel the request.
    valid_until: ?i64 = null,
};
