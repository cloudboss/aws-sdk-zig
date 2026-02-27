const aws = @import("aws");

pub const TagResourceResult = struct {
    /// The list of tags associated with the resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
