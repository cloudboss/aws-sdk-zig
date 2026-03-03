const CapacitySize = @import("capacity_size.zig").CapacitySize;
const TrafficRoutingConfigType = @import("traffic_routing_config_type.zig").TrafficRoutingConfigType;

/// Defines the traffic routing strategy during an endpoint deployment to shift
/// traffic from the old fleet to the new fleet.
pub const TrafficRoutingConfig = struct {
    /// Batch size for the first step to turn on traffic on the new endpoint fleet.
    /// `Value` must be less than or equal to 50% of the variant's total instance
    /// count.
    canary_size: ?CapacitySize = null,

    /// Batch size for each step to turn on traffic on the new endpoint fleet.
    /// `Value` must be 10-50% of the variant's total instance count.
    linear_step_size: ?CapacitySize = null,

    /// Traffic routing strategy type.
    ///
    /// * `ALL_AT_ONCE`: Endpoint traffic shifts to the new fleet in a single step.
    /// * `CANARY`: Endpoint traffic shifts to the new fleet in two steps. The first
    ///   step is the canary, which is a small portion of the traffic. The second
    ///   step is the remainder of the traffic.
    /// * `LINEAR`: Endpoint traffic shifts to the new fleet in n steps of a
    ///   configurable size.
    @"type": TrafficRoutingConfigType,

    /// The waiting time (in seconds) between incremental steps to turn on traffic
    /// on the new endpoint fleet.
    wait_interval_in_seconds: i32,

    pub const json_field_names = .{
        .canary_size = "CanarySize",
        .linear_step_size = "LinearStepSize",
        .@"type" = "Type",
        .wait_interval_in_seconds = "WaitIntervalInSeconds",
    };
};
