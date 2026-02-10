const ArchitectureValues = @import("architecture_values.zig").ArchitectureValues;
const ShutdownBehavior = @import("shutdown_behavior.zig").ShutdownBehavior;
const InstanceType = @import("instance_type.zig").InstanceType;
const Placement = @import("placement.zig").Placement;
const UserData = @import("user_data.zig").UserData;

/// Describes the launch specification for VM import.
pub const ImportInstanceLaunchSpecification = struct {
    /// Reserved.
    additional_info: ?[]const u8,

    /// The architecture of the instance.
    architecture: ?ArchitectureValues,

    /// The security group IDs.
    group_ids: ?[]const []const u8,

    /// The security group names.
    group_names: ?[]const []const u8,

    /// Indicates whether an instance stops or terminates when you initiate shutdown
    /// from the instance (using the
    /// operating system command for system shutdown).
    instance_initiated_shutdown_behavior: ?ShutdownBehavior,

    /// The instance type. For more information about the instance types that you
    /// can import, see [Instance
    /// Types](https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-instance-types) in the
    /// VM Import/Export User Guide.
    instance_type: ?InstanceType,

    /// Indicates whether monitoring is enabled.
    monitoring: ?bool,

    /// The placement information for the instance.
    placement: ?Placement,

    /// [EC2-VPC] An available IP address from the IP address range of the subnet.
    private_ip_address: ?[]const u8,

    /// [EC2-VPC] The ID of the subnet in which to launch the instance.
    subnet_id: ?[]const u8,

    /// The Base64-encoded user data to make available to the instance.
    user_data: ?UserData,
};
