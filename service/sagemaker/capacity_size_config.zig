const NodeUnavailabilityType = @import("node_unavailability_type.zig").NodeUnavailabilityType;

/// The configuration of the size measurements of the AMI update. Using this
/// configuration, you can specify whether SageMaker should update your instance
/// group by an amount or percentage of instances.
pub const CapacitySizeConfig = struct {
    /// Specifies whether SageMaker should process the update by amount or
    /// percentage of instances.
    type: NodeUnavailabilityType,

    /// Specifies the amount or percentage of instances SageMaker updates at a time.
    value: i32,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
