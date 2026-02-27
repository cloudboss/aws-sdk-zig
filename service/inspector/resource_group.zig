const ResourceGroupTag = @import("resource_group_tag.zig").ResourceGroupTag;

/// Contains information about a resource group. The resource group defines a
/// set of tags
/// that, when queried, identify the AWS resources that make up the assessment
/// target. This
/// data type is used as the response element in the DescribeResourceGroups
/// action.
pub const ResourceGroup = struct {
    /// The ARN of the resource group.
    arn: []const u8,

    /// The time at which resource group is created.
    created_at: i64,

    /// The tags (key and value pairs) of the resource group. This data type
    /// property is used
    /// in the CreateResourceGroup action.
    tags: []const ResourceGroupTag,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .tags = "tags",
    };
};
