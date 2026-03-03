const AdMarkerPassthrough = @import("ad_marker_passthrough.zig").AdMarkerPassthrough;

/// The configuration for manifest processing rules. Manifest processing rules
/// enable customization of the personalized manifests created by MediaTailor.
pub const ManifestProcessingRules = struct {
    /// For HLS, when set to `true`, MediaTailor passes through `EXT-X-CUE-IN`,
    /// `EXT-X-CUE-OUT`, and `EXT-X-SPLICEPOINT-SCTE35` ad markers from the origin
    /// manifest to the MediaTailor personalized manifest.
    ///
    /// No logic is applied to these ad markers. For example, if `EXT-X-CUE-OUT` has
    /// a value of `60`, but no ads are filled for that ad break, MediaTailor will
    /// not set the value to `0`.
    ad_marker_passthrough: ?AdMarkerPassthrough = null,

    pub const json_field_names = .{
        .ad_marker_passthrough = "AdMarkerPassthrough",
    };
};
