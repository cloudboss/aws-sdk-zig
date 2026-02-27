/// Placeholder documentation for ChannelEngineVersionResponse
pub const ChannelEngineVersionResponse = struct {
    /// The UTC time when the version expires.
    expiration_date: ?i64,

    /// The build identifier for this version of the channel version.
    version: ?[]const u8,

    pub const json_field_names = .{
        .expiration_date = "ExpirationDate",
        .version = "Version",
    };
};
