/// Specifies information needed to stream using the SRT protocol.
pub const Srt = struct {
    /// The endpoint to be used when streaming with IVS using the SRT protocol.
    endpoint: ?[]const u8 = null,

    /// Auto-generated passphrase to enable encryption. This field is applicable
    /// only if the end user has *not* enabled the `insecureIngest` option for the
    /// channel.
    passphrase: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint = "endpoint",
        .passphrase = "passphrase",
    };
};
