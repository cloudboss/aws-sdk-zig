const AutoScalingUpdate = @import("auto_scaling_update.zig").AutoScalingUpdate;
const ProvisionedCapacityUpdate = @import("provisioned_capacity_update.zig").ProvisionedCapacityUpdate;

/// The target capacity for the connector. The capacity can be auto scaled or
/// provisioned.
pub const CapacityUpdate = struct {
    /// The target auto scaling setting.
    auto_scaling: ?AutoScalingUpdate,

    /// The target settings for provisioned capacity.
    provisioned_capacity: ?ProvisionedCapacityUpdate,

    pub const json_field_names = .{
        .auto_scaling = "autoScaling",
        .provisioned_capacity = "provisionedCapacity",
    };
};
