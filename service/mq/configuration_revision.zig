/// Returns information about the specified configuration revision.
pub const ConfigurationRevision = struct {
    /// Required. The date and time of the configuration revision.
    created: i64,

    /// The description of the configuration revision.
    description: ?[]const u8,

    /// Required. The revision number of the configuration.
    revision: i32,

    pub const json_field_names = .{
        .created = "Created",
        .description = "Description",
        .revision = "Revision",
    };
};
