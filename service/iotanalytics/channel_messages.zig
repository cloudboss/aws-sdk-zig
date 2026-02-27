/// Specifies one or more sets of channel messages.
pub const ChannelMessages = struct {
    /// Specifies one or more keys that identify the Amazon Simple Storage Service
    /// (Amazon S3) objects that save your
    /// channel messages.
    ///
    /// You must use the full path for the key.
    ///
    /// Example path: `channel/mychannel/__dt=2020-02-29
    /// 00:00:00/1582940490000_1582940520000_123456789012_mychannel_0_2118.0.json.gz`
    s_3_paths: ?[]const []const u8,

    pub const json_field_names = .{
        .s_3_paths = "s3Paths",
    };
};
