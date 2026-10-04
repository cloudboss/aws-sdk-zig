const InstanceTypeItem = @import("instance_type_item.zig").InstanceTypeItem;

/// Describes the instance type compatibility rules for an AMI, including lists
/// of supported
/// and unsupported instance type patterns.
pub const InstanceTypeSpecification = struct {
    /// The instance types that the AMI supports.
    supported_instance_types: ?[]const InstanceTypeItem = null,

    /// The instance types that the AMI does not support.
    unsupported_instance_types: ?[]const InstanceTypeItem = null,
};
