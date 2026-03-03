const aws = @import("aws");

const VpcLinkStatus = @import("vpc_link_status.zig").VpcLinkStatus;
const VpcLinkVersion = @import("vpc_link_version.zig").VpcLinkVersion;

/// Represents a VPC link.
pub const VpcLink = struct {
    /// The timestamp when the VPC link was created.
    created_date: ?i64 = null,

    /// The name of the VPC link.
    name: []const u8,

    /// A list of security group IDs for the VPC link.
    security_group_ids: []const []const u8,

    /// A list of subnet IDs to include in the VPC link.
    subnet_ids: []const []const u8,

    /// Tags for the VPC link.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the VPC link.
    vpc_link_id: []const u8,

    /// The status of the VPC link.
    vpc_link_status: ?VpcLinkStatus = null,

    /// A message summarizing the cause of the status of the VPC link.
    vpc_link_status_message: ?[]const u8 = null,

    /// The version of the VPC link.
    vpc_link_version: ?VpcLinkVersion = null,

    pub const json_field_names = .{
        .created_date = "CreatedDate",
        .name = "Name",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .vpc_link_id = "VpcLinkId",
        .vpc_link_status = "VpcLinkStatus",
        .vpc_link_status_message = "VpcLinkStatusMessage",
        .vpc_link_version = "VpcLinkVersion",
    };
};
