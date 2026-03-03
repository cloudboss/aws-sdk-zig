/// A structure that contains information about the RUM app monitor.
pub const AppMonitorDetails = struct {
    /// The unique ID of the app monitor.
    id: ?[]const u8 = null,

    /// The name of the app monitor.
    name: ?[]const u8 = null,

    /// The version of the app monitor.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .version = "version",
    };
};
