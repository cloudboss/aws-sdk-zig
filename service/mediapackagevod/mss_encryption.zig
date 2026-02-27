const SpekeKeyProvider = @import("speke_key_provider.zig").SpekeKeyProvider;

/// A Microsoft Smooth Streaming (MSS) encryption configuration.
pub const MssEncryption = struct {
    speke_key_provider: SpekeKeyProvider,

    pub const json_field_names = .{
        .speke_key_provider = "SpekeKeyProvider",
    };
};
