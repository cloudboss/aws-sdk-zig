const AuthMode = @import("auth_mode.zig").AuthMode;

/// Details for an Amazon EMR Studio, including ID, Name, VPC, and Description.
/// To fetch additional details such as subnets, IAM roles,
/// security groups, and tags for the Studio, use the DescribeStudio API.
pub const StudioSummary = struct {
    /// Specifies whether the Studio authenticates users using IAM or IAM Identity
    /// Center.
    auth_mode: ?AuthMode = null,

    /// The time when the Amazon EMR Studio was created.
    creation_time: ?i64 = null,

    /// The detailed description of the Amazon EMR Studio.
    description: ?[]const u8 = null,

    /// The name of the Amazon EMR Studio.
    name: ?[]const u8 = null,

    /// The ID of the Amazon EMR Studio.
    studio_id: ?[]const u8 = null,

    /// The unique access URL of the Amazon EMR Studio.
    url: ?[]const u8 = null,

    /// The ID of the Virtual Private Cloud (Amazon VPC) associated with the Amazon
    /// EMR Studio.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_mode = "AuthMode",
        .creation_time = "CreationTime",
        .description = "Description",
        .name = "Name",
        .studio_id = "StudioId",
        .url = "Url",
        .vpc_id = "VpcId",
    };
};
