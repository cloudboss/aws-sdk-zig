const HarvestedDashManifest = @import("harvested_dash_manifest.zig").HarvestedDashManifest;
const HarvestedHlsManifest = @import("harvested_hls_manifest.zig").HarvestedHlsManifest;
const HarvestedLowLatencyHlsManifest = @import("harvested_low_latency_hls_manifest.zig").HarvestedLowLatencyHlsManifest;

/// A collection of harvested manifests of different types.
pub const HarvestedManifests = struct {
    /// A list of harvested DASH manifests.
    dash_manifests: ?[]const HarvestedDashManifest,

    /// A list of harvested HLS manifests.
    hls_manifests: ?[]const HarvestedHlsManifest,

    /// A list of harvested Low-Latency HLS manifests.
    low_latency_hls_manifests: ?[]const HarvestedLowLatencyHlsManifest,

    pub const json_field_names = .{
        .dash_manifests = "DashManifests",
        .hls_manifests = "HlsManifests",
        .low_latency_hls_manifests = "LowLatencyHlsManifests",
    };
};
