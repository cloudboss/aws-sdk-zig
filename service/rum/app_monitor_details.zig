/// A structure that contains information about the RUM app monitor.
pub const AppMonitorDetails = struct {
    /// The unique ID of the app monitor.
    id: ?[]const u8,

    /// The name of the app monitor.
    name: ?[]const u8,

    /// The version of the app monitor.
    version: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .version = "version",
    };
};
