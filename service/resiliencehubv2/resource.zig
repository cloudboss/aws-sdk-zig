/// Represents an AWS resource discovered by Resilience Hub.
pub const Resource = struct {
    /// The Availability Zone ID of the Availability Zone that hosts the resource,
    /// such as use1-az1. The Availability Zone ID is consistent across Amazon Web
    /// Services (AWS) accounts, unlike the Availability Zone name.
    availability_zone_id: ?[]const u8 = null,

    /// The name of the Availability Zone that hosts the resource, such as
    /// us-west-2a.
    availability_zone_name: ?[]const u8 = null,

    /// The AWS account ID that owns the resource.
    aws_account_id: ?[]const u8 = null,

    /// The AWS Region where the resource is located.
    aws_region: ?[]const u8 = null,

    /// The identifier of the single parent resource that contains this resource,
    /// used to represent containment relationships in the resource topology. A
    /// resource has at most one containment parent.
    containment_parent_id: ?[]const u8 = null,

    /// The identifier of the resource.
    identifier: []const u8,

    /// The identifier of the logical resource group that this resource belongs to.
    /// Resources that share this identifier are managed as a single unit.
    logical_resource_group_id: ?[]const u8 = null,

    /// The type of the resource.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone_id = "availabilityZoneId",
        .availability_zone_name = "availabilityZoneName",
        .aws_account_id = "awsAccountId",
        .aws_region = "awsRegion",
        .containment_parent_id = "containmentParentId",
        .identifier = "identifier",
        .logical_resource_group_id = "logicalResourceGroupId",
        .resource_type = "resourceType",
    };
};
