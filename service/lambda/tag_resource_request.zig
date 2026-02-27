const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The resource's Amazon Resource Name (ARN).
    resource: []const u8,

    /// A list of tags to apply to the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource = "Resource",
        .tags = "Tags",
    };
};
