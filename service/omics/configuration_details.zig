/// Minimal details for a configuration resource.
pub const ConfigurationDetails = struct {
    /// Unique resource identifier for the configuration.
    arn: ?[]const u8 = null,

    /// User-friendly name for the configuration.
    name: ?[]const u8 = null,

    /// Unique identifier for the configuration.
    uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .uuid = "uuid",
    };
};
