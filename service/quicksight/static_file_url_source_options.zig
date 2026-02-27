/// The structure that contains the URL to download the static file from.
pub const StaticFileUrlSourceOptions = struct {
    /// The URL to download the static file from.
    url: []const u8,

    pub const json_field_names = .{
        .url = "Url",
    };
};
