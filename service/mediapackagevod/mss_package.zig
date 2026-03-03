const MssEncryption = @import("mss_encryption.zig").MssEncryption;
const MssManifest = @import("mss_manifest.zig").MssManifest;

/// A Microsoft Smooth Streaming (MSS) PackagingConfiguration.
pub const MssPackage = struct {
    encryption: ?MssEncryption = null,

    /// A list of MSS manifest configurations.
    mss_manifests: []const MssManifest,

    /// The duration (in seconds) of each segment.
    segment_duration_seconds: ?i32 = null,

    pub const json_field_names = .{
        .encryption = "Encryption",
        .mss_manifests = "MssManifests",
        .segment_duration_seconds = "SegmentDurationSeconds",
    };
};
