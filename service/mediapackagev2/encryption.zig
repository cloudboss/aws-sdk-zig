const EncryptionMethod = @import("encryption_method.zig").EncryptionMethod;
const SpekeKeyProvider = @import("speke_key_provider.zig").SpekeKeyProvider;

/// The parameters for encrypting content.
pub const Encryption = struct {
    /// Excludes SEIG and SGPD boxes from segment metadata in CMAF containers.
    ///
    /// When set to `true`, MediaPackage omits these DRM metadata boxes from CMAF
    /// segments, which can improve compatibility with certain devices and players
    /// that don't support these boxes.
    ///
    /// Important considerations:
    ///
    /// * This setting only affects CMAF container formats
    /// * Key rotation can still be handled through media playlist signaling
    /// * PSSH and TENC boxes remain unaffected
    /// * Default behavior is preserved when this setting is disabled
    ///
    /// Valid values: `true` | `false`
    ///
    /// Default: `false`
    cmaf_exclude_segment_drm_metadata: ?bool = null,

    /// A 128-bit, 16-byte hex value represented by a 32-character string, used in
    /// conjunction with the key for encrypting content. If you don't specify a
    /// value, then MediaPackage creates the constant initialization vector (IV).
    constant_initialization_vector: ?[]const u8 = null,

    /// The encryption method to use.
    encryption_method: EncryptionMethod,

    /// The frequency (in seconds) of key changes for live workflows, in which
    /// content is streamed real time. The service retrieves content keys before the
    /// live content begins streaming, and then retrieves them as needed over the
    /// lifetime of the workflow. By default, key rotation is set to 300 seconds (5
    /// minutes), the minimum rotation interval, which is equivalent to setting it
    /// to 300. If you don't enter an interval, content keys aren't rotated.
    ///
    /// The following example setting causes the service to rotate keys every thirty
    /// minutes: `1800`
    key_rotation_interval_seconds: ?i32 = null,

    /// The parameters for the SPEKE key provider.
    speke_key_provider: SpekeKeyProvider,

    pub const json_field_names = .{
        .cmaf_exclude_segment_drm_metadata = "CmafExcludeSegmentDrmMetadata",
        .constant_initialization_vector = "ConstantInitializationVector",
        .encryption_method = "EncryptionMethod",
        .key_rotation_interval_seconds = "KeyRotationIntervalSeconds",
        .speke_key_provider = "SpekeKeyProvider",
    };
};
