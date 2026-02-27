const AutoScalingDescription = @import("auto_scaling_description.zig").AutoScalingDescription;
const ProvisionedCapacityDescription = @import("provisioned_capacity_description.zig").ProvisionedCapacityDescription;

/// A description of the connector's capacity.
pub const CapacityDescription = struct {
    /// Describes the connector's auto scaling capacity.
    auto_scaling: ?AutoScalingDescription,

    /// Describes a connector's provisioned capacity.
    provisioned_capacity: ?ProvisionedCapacityDescription,

    pub const json_field_names = .{
        .auto_scaling = "autoScaling",
        .provisioned_capacity = "provisionedCapacity",
    };
};
