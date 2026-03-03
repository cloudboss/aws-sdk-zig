/// A structure containing the schema version information.
pub const SchemaVersionNumber = struct {
    /// The latest version available for the schema.
    latest_version: bool = false,

    /// The version number of the schema.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .latest_version = "LatestVersion",
        .version_number = "VersionNumber",
    };
};
