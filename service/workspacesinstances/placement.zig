const TenancyEnum = @import("tenancy_enum.zig").TenancyEnum;

/// Defines instance placement configuration for WorkSpace Instance.
pub const Placement = struct {
    /// Specifies host affinity for dedicated instances.
    affinity: ?[]const u8 = null,

    /// Identifies the specific AWS availability zone.
    availability_zone: ?[]const u8 = null,

    /// Unique identifier for placement group.
    group_id: ?[]const u8 = null,

    /// Name of the placement group.
    group_name: ?[]const u8 = null,

    /// Identifies the specific dedicated host.
    host_id: ?[]const u8 = null,

    /// ARN of the host resource group.
    host_resource_group_arn: ?[]const u8 = null,

    /// Specifies partition number for partition placement groups.
    partition_number: ?i32 = null,

    /// Defines instance tenancy configuration.
    tenancy: ?TenancyEnum = null,

    pub const json_field_names = .{
        .affinity = "Affinity",
        .availability_zone = "AvailabilityZone",
        .group_id = "GroupId",
        .group_name = "GroupName",
        .host_id = "HostId",
        .host_resource_group_arn = "HostResourceGroupArn",
        .partition_number = "PartitionNumber",
        .tenancy = "Tenancy",
    };
};
