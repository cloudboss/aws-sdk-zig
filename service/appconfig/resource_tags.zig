const aws = @import("aws");

pub const ResourceTags = struct {
    /// Metadata to assign to AppConfig resources. Tags help organize and categorize
    /// your AppConfig resources. Each tag consists of a key and an optional value,
    /// both
    /// of which you define.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
