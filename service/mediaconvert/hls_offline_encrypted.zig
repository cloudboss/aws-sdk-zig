/// Enable this setting to insert the EXT-X-SESSION-KEY element into the master
/// playlist. This allows for offline Apple HLS FairPlay content protection.
pub const HlsOfflineEncrypted = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
