/// The transportable tablespace configuration used when creating an Autonomous
/// Database.
pub const TransportableTablespace = struct {
    /// The URL of the transportable tablespace bundle to use when creating the
    /// Autonomous Database.
    tts_bundle_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .tts_bundle_url = "ttsBundleUrl",
    };
};
