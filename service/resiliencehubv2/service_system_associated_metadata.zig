/// Metadata for a service system associated event.
pub const ServiceSystemAssociatedMetadata = struct {
    system_arn: ?[]const u8 = null,

    /// The name of the associated system.
    system_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .system_arn = "systemArn",
        .system_name = "systemName",
    };
};
