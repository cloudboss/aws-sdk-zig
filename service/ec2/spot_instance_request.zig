const SpotInstanceStateFault = @import("spot_instance_state_fault.zig").SpotInstanceStateFault;
const InstanceInterruptionBehavior = @import("instance_interruption_behavior.zig").InstanceInterruptionBehavior;
const LaunchSpecification = @import("launch_specification.zig").LaunchSpecification;
const RIProductDescription = @import("ri_product_description.zig").RIProductDescription;
const SpotInstanceState = @import("spot_instance_state.zig").SpotInstanceState;
const SpotInstanceStatus = @import("spot_instance_status.zig").SpotInstanceStatus;
const Tag = @import("tag.zig").Tag;
const SpotInstanceType = @import("spot_instance_type.zig").SpotInstanceType;

/// Describes a Spot Instance request.
pub const SpotInstanceRequest = struct {
    /// Deprecated.
    actual_block_hourly_price: ?[]const u8,

    /// The Availability Zone group. If you specify the same Availability Zone group
    /// for all Spot Instance requests, all Spot Instances are launched in the same
    /// Availability Zone.
    availability_zone_group: ?[]const u8,

    /// Deprecated.
    block_duration_minutes: ?i32,

    /// The date and time when the Spot Instance request was created, in UTC format
    /// (for example, *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    create_time: ?i64,

    /// The fault codes for the Spot Instance request, if any.
    fault: ?SpotInstanceStateFault,

    /// The instance ID, if an instance has been launched to fulfill the Spot
    /// Instance request.
    instance_id: ?[]const u8,

    /// The behavior when a Spot Instance is interrupted.
    instance_interruption_behavior: ?InstanceInterruptionBehavior,

    /// The Availability Zone in which the request is launched.
    ///
    /// Either `launchedAvailabilityZone` or `launchedAvailabilityZoneId` can be
    /// specified, but not both
    launched_availability_zone: ?[]const u8,

    /// The ID of the Availability Zone in which the request is launched.
    ///
    /// Either `launchedAvailabilityZone` or `launchedAvailabilityZoneId` can be
    /// specified, but not both
    launched_availability_zone_id: ?[]const u8,

    /// The instance launch group. Launch groups are Spot Instances that launch
    /// together and terminate together.
    launch_group: ?[]const u8,

    /// Additional information for launching instances.
    launch_specification: ?LaunchSpecification,

    /// The product description associated with the Spot Instance.
    product_description: ?RIProductDescription,

    /// The ID of the Spot Instance request.
    spot_instance_request_id: ?[]const u8,

    /// The maximum price per unit hour that you are willing to pay for a Spot
    /// Instance. We do not recommend
    /// using this parameter because it can lead to increased interruptions. If you
    /// do not specify this parameter, you will pay the current Spot price.
    ///
    /// If you specify a maximum price, your instances will be interrupted more
    /// frequently than if you do not specify this parameter.
    spot_price: ?[]const u8,

    /// The state of the Spot Instance request. Spot request status information
    /// helps track your Spot
    /// Instance requests. For more information, see [Spot request
    /// status](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-request-status.html) in the
    /// *Amazon EC2 User Guide*.
    state: ?SpotInstanceState,

    /// The status code and status message describing the Spot Instance request.
    status: ?SpotInstanceStatus,

    /// Any tags assigned to the resource.
    tags: ?[]const Tag,

    /// The Spot Instance request type.
    @"type": ?SpotInstanceType,

    /// The start date of the request, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    /// The request becomes active at this date and time.
    valid_from: ?i64,

    /// The end date of the request, in UTC format
    /// (*YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    ///
    /// * For a persistent request, the request remains active until the
    ///   `validUntil` date
    /// and time is reached. Otherwise, the request remains active until you cancel
    /// it.
    ///
    /// * For a one-time request, the request remains active until all instances
    ///   launch,
    /// the request is canceled, or the `validUntil` date and time is reached. By
    /// default, the
    /// request is valid for 7 days from the date the request was created.
    valid_until: ?i64,
};
