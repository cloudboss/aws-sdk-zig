const Tenancy = @import("tenancy.zig").Tenancy;

/// Describes the placement of an instance.
pub const Placement = struct {
    /// The affinity setting for the instance on the Dedicated Host.
    ///
    /// This parameter is not supported for
    /// [CreateFleet](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet) or [ImportInstance](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html).
    affinity: ?[]const u8 = null,

    /// The Availability Zone of the instance.
    ///
    /// On input, you can specify `AvailabilityZone` or `AvailabilityZoneId`,
    /// but not both. If you specify neither one, Amazon EC2 automatically selects
    /// an Availability Zone
    /// for you.
    ///
    /// This parameter is not supported for
    /// [CreateFleet](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone of the instance.
    ///
    /// On input, you can specify `AvailabilityZone` or `AvailabilityZoneId`,
    /// but not both. If you specify neither one, Amazon EC2 automatically selects
    /// an Availability Zone
    /// for you.
    ///
    /// This parameter is not supported for
    /// [CreateFleet](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
    availability_zone_id: ?[]const u8 = null,

    /// The ID of the placement group that the instance is in.
    ///
    /// On input, you can specify `GroupId` or `GroupName`,
    /// but not both.
    group_id: ?[]const u8 = null,

    /// The name of the placement group that the instance is in.
    ///
    /// On input, you can specify `GroupId` or `GroupName`,
    /// but not both.
    group_name: ?[]const u8 = null,

    /// The ID of the Dedicated Host on which the instance resides.
    ///
    /// This parameter is not supported for
    /// [CreateFleet](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet) or [ImportInstance](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html).
    host_id: ?[]const u8 = null,

    /// The ARN of the host resource group in which to launch the instances.
    ///
    /// On input, if you specify this parameter, either omit the **Tenancy**
    /// parameter or set it to `host`.
    ///
    /// This parameter is not supported for
    /// [CreateFleet](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
    host_resource_group_arn: ?[]const u8 = null,

    /// The number of the partition that the instance is in. Valid only if the
    /// placement group
    /// strategy is set to `partition`.
    ///
    /// This parameter is not supported for
    /// [CreateFleet](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
    partition_number: ?i32 = null,

    /// Reserved for future use.
    spread_domain: ?[]const u8 = null,

    /// The tenancy of the instance. An instance with a
    /// tenancy of `dedicated` runs on single-tenant hardware.
    ///
    /// This parameter is not supported for
    /// [CreateFleet](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet). The
    /// `host` tenancy is not supported for
    /// [ImportInstance](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html) or
    /// for T3 instances that are configured for the `unlimited` CPU credit
    /// option.
    tenancy: ?Tenancy = null,
};
