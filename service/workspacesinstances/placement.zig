const TenancyEnum = @import("tenancy_enum.zig").TenancyEnum;

/// Defines instance placement configuration for WorkSpace Instance.
pub const Placement = struct {
    /// Specifies host affinity for dedicated instances.
    affinity: ?[]const u8,

    /// Identifies the specific AWS availability zone.
    availability_zone: ?[]const u8,

    /// Unique identifier for placement group.
    group_id: ?[]const u8,

    /// Name of the placement group.
    group_name: ?[]const u8,

    /// Identifies the specific dedicated host.
    host_id: ?[]const u8,

    /// ARN of the host resource group.
    host_resource_group_arn: ?[]const u8,

    /// Specifies partition number for partition placement groups.
    partition_number: ?i32,

    /// Defines instance tenancy configuration.
    tenancy: ?TenancyEnum,

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
