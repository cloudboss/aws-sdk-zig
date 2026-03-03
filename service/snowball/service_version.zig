/// The version of the requested service.
pub const ServiceVersion = struct {
    /// The version number of the requested service.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .version = "Version",
    };
};
