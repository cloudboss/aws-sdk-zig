const EbsStatusSummary = @import("ebs_status_summary.zig").EbsStatusSummary;
const InstanceStatusEvent = @import("instance_status_event.zig").InstanceStatusEvent;
const InstanceState = @import("instance_state.zig").InstanceState;
const InstanceStatusSummary = @import("instance_status_summary.zig").InstanceStatusSummary;
const OperatorResponse = @import("operator_response.zig").OperatorResponse;

/// Describes the status of an instance.
pub const InstanceStatus = struct {
    /// Reports impaired functionality that stems from an attached Amazon EBS volume
    /// that is
    /// unreachable and unable to complete I/O operations.
    attached_ebs_status: ?EbsStatusSummary = null,

    /// The Availability Zone of the instance.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone of the instance.
    availability_zone_id: ?[]const u8 = null,

    /// Any scheduled events associated with the instance.
    events: ?[]const InstanceStatusEvent = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The intended state of the instance. DescribeInstanceStatus requires
    /// that an instance be in the `running` state.
    instance_state: ?InstanceState = null,

    /// Reports impaired functionality that stems from issues internal to the
    /// instance, such
    /// as impaired reachability.
    instance_status: ?InstanceStatusSummary = null,

    /// The service provider that manages the instance.
    operator: ?OperatorResponse = null,

    /// The Amazon Resource Name (ARN) of the Outpost.
    outpost_arn: ?[]const u8 = null,

    /// Reports impaired functionality that stems from issues related to the systems
    /// that
    /// support an instance, such as hardware failures and network connectivity
    /// problems.
    system_status: ?InstanceStatusSummary = null,
};
