const aws = @import("aws");

/// The request to add tags to a resource.
pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the web function.
    resource: []const u8,

    /// A map of tag keys and values to add to the web function.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource = "resource",
        .tags = "tags",
    };
};
