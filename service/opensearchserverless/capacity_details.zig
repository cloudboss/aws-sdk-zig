const AutoscalingStatus = @import("autoscaling_status.zig").AutoscalingStatus;

/// Capacity details for an OpenSearch Serverless collection group, including
/// the current capacity and autoscaling status.
pub const CapacityDetails = struct {
    /// The current autoscaling status for the collection group.
    autoscaling_status: ?AutoscalingStatus = null,

    /// The current capacity in OpenSearch Compute Units (OCUs).
    capacity_in_ocu: ?f32 = null,

    pub const json_field_names = .{
        .autoscaling_status = "autoscalingStatus",
        .capacity_in_ocu = "capacityInOcu",
    };
};
