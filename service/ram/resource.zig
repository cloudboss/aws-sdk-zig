const ResourceRegionScope = @import("resource_region_scope.zig").ResourceRegionScope;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Describes a resource associated with a resource share in RAM.
pub const Resource = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource.
    arn: ?[]const u8,

    /// The date and time when the resource was associated with the resource share.
    creation_time: ?i64,

    /// The date an time when the association between the resource and the resource
    /// share was
    /// last updated.
    last_updated_time: ?i64,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource group. This value is available only if the resource is
    /// part of a resource group.
    resource_group_arn: ?[]const u8,

    /// Specifies the scope of visibility of this resource:
    ///
    /// * **REGIONAL** – The resource can be
    /// accessed only by using requests that target the Amazon Web Services Region
    /// in which the
    /// resource exists.
    ///
    /// * **GLOBAL** – The resource can be accessed
    /// from any Amazon Web Services Region.
    resource_region_scope: ?ResourceRegionScope,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource share this resource is associated with.
    resource_share_arn: ?[]const u8,

    /// The current status of the resource.
    status: ?ResourceStatus,

    /// A message about the status of the resource.
    status_message: ?[]const u8,

    /// The resource type. This takes the form of:
    /// `service-code`:`resource-code`, and is case-insensitive. For
    /// example, an Amazon EC2 Subnet would be represented by the string
    /// `ec2:subnet`.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .last_updated_time = "lastUpdatedTime",
        .resource_group_arn = "resourceGroupArn",
        .resource_region_scope = "resourceRegionScope",
        .resource_share_arn = "resourceShareArn",
        .status = "status",
        .status_message = "statusMessage",
        .@"type" = "type",
    };
};
