const aws = @import("aws");

const VpcLinkStatus = @import("vpc_link_status.zig").VpcLinkStatus;

/// An API Gateway VPC link for a RestApi to access resources in an Amazon
/// Virtual Private Cloud (VPC).
pub const VpcLink = struct {
    /// The description of the VPC link.
    description: ?[]const u8,

    /// The identifier of the VpcLink. It is used in an Integration to reference
    /// this VpcLink.
    id: ?[]const u8,

    /// The name used to label and identify the VPC link.
    name: ?[]const u8,

    /// The status of the VPC link. The valid values are `AVAILABLE`, `PENDING`,
    /// `DELETING`, or `FAILED`. Deploying an API will wait if the status is
    /// `PENDING` and will fail if the status is `DELETING`.
    status: ?VpcLinkStatus,

    /// A description about the VPC link status.
    status_message: ?[]const u8,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// The ARN of the network load balancer of the VPC targeted by the VPC link.
    /// The network load balancer must be owned by the same Amazon Web Services
    /// account of the API owner.
    target_arns: ?[]const []const u8,

    pub const json_field_names = .{
        .description = "description",
        .id = "id",
        .name = "name",
        .status = "status",
        .status_message = "statusMessage",
        .tags = "tags",
        .target_arns = "targetArns",
    };
};
