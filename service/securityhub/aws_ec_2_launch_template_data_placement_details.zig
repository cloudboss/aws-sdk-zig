/// Provides details about the placement of an Amazon EC2 instance.
pub const AwsEc2LaunchTemplateDataPlacementDetails = struct {
    /// The affinity setting for an instance on an EC2 Dedicated Host.
    affinity: ?[]const u8 = null,

    /// The Availability Zone for the instance.
    availability_zone: ?[]const u8 = null,

    /// The name of the placement group for the instance.
    group_name: ?[]const u8 = null,

    /// The ID of the Dedicated Host for the instance.
    host_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the host resource group in which to launch
    /// the instances.
    host_resource_group_arn: ?[]const u8 = null,

    /// The number of the partition the instance should launch in.
    partition_number: ?i32 = null,

    /// Reserved for future use.
    spread_domain: ?[]const u8 = null,

    /// The tenancy of the instance (if the instance is running in a VPC). An
    /// instance with a tenancy of dedicated runs on single-tenant hardware.
    tenancy: ?[]const u8 = null,

    pub const json_field_names = .{
        .affinity = "Affinity",
        .availability_zone = "AvailabilityZone",
        .group_name = "GroupName",
        .host_id = "HostId",
        .host_resource_group_arn = "HostResourceGroupArn",
        .partition_number = "PartitionNumber",
        .spread_domain = "SpreadDomain",
        .tenancy = "Tenancy",
    };
};
