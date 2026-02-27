const ResourceTagSource = @import("resource_tag_source.zig").ResourceTagSource;

/// The resource tag of the project.
pub const ResourceTag = struct {
    /// The key of the resource tag of the project.
    key: []const u8,

    /// The source of the resource tag of the project.
    source: ResourceTagSource,

    /// The value of the resource tag of the project.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .source = "source",
        .value = "value",
    };
};
