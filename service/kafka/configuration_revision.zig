/// Describes a configuration revision.
pub const ConfigurationRevision = struct {
    /// The time when the configuration revision was created.
    creation_time: i64,

    /// The description of the configuration revision.
    description: ?[]const u8,

    /// The revision number.
    revision: i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .description = "Description",
        .revision = "Revision",
    };
};
