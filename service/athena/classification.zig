const aws = @import("aws");

/// A classification refers to a set of specific configurations.
pub const Classification = struct {
    /// The name of the configuration classification.
    name: ?[]const u8,

    /// A set of properties specified within a configuration classification.
    properties: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .name = "Name",
        .properties = "Properties",
    };
};
