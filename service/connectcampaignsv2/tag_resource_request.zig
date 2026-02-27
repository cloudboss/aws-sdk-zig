const aws = @import("aws");

/// The request for TagResource API.
pub const TagResourceRequest = struct {
    arn: []const u8,

    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .tags = "tags",
    };
};
