const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the medical imaging resource that tags are
    /// being added to.
    resource_arn: []const u8,

    /// The user-specified key and value tag pairs added to a medical imaging
    /// resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
