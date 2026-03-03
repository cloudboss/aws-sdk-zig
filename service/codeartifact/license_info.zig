/// Details of the license data.
pub const LicenseInfo = struct {
    /// Name of the license.
    name: ?[]const u8 = null,

    /// The URL for license data.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .url = "url",
    };
};
