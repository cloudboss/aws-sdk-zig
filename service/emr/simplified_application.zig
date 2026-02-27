/// The returned release label application names or versions.
pub const SimplifiedApplication = struct {
    /// The returned release label application name. For example, `hadoop`.
    name: ?[]const u8,

    /// The returned release label application version. For example, `3.2.1`.
    version: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .version = "Version",
    };
};
