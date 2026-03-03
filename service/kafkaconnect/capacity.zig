const AutoScaling = @import("auto_scaling.zig").AutoScaling;
const ProvisionedCapacity = @import("provisioned_capacity.zig").ProvisionedCapacity;

/// Information about the capacity of the connector, whether it is auto scaled
/// or provisioned.
pub const Capacity = struct {
    /// Information about the auto scaling parameters for the connector.
    auto_scaling: ?AutoScaling = null,

    /// Details about a fixed capacity allocated to a connector.
    provisioned_capacity: ?ProvisionedCapacity = null,

    pub const json_field_names = .{
        .auto_scaling = "autoScaling",
        .provisioned_capacity = "provisionedCapacity",
    };
};
