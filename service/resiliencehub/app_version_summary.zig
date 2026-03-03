/// Version of an application.
pub const AppVersionSummary = struct {
    /// Version of an application.
    app_version: []const u8,

    /// Creation time of the application version.
    creation_time: ?i64 = null,

    /// Identifier of the application version.
    identifier: ?i64 = null,

    /// Name of the application version.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_version = "appVersion",
        .creation_time = "creationTime",
        .identifier = "identifier",
        .version_name = "versionName",
    };
};
