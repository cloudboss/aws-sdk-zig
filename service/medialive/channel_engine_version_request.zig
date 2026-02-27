/// Placeholder documentation for ChannelEngineVersionRequest
pub const ChannelEngineVersionRequest = struct {
    /// The build identifier of the engine version to use for this channel. Specify
    /// 'DEFAULT' to reset to the default version.
    version: ?[]const u8,

    pub const json_field_names = .{
        .version = "Version",
    };
};
