const AdMarkerDash = @import("ad_marker_dash.zig").AdMarkerDash;
const ScteInManifests = @import("scte_in_manifests.zig").ScteInManifests;

/// The SCTE configuration.
pub const ScteDash = struct {
    /// Choose how ad markers are included in the packaged content. If you include
    /// ad markers in the content stream in your upstream encoders, then you need to
    /// inform MediaPackage what to do with the ad markers in the output.
    ///
    /// Value description:
    ///
    /// * `Binary` - The SCTE-35 marker is expressed as a hex-string (Base64 string)
    ///   rather than full XML.
    /// * `XML` - The SCTE marker is expressed fully in XML.
    ad_marker_dash: ?AdMarkerDash = null,

    /// Controls which SCTE-35 events appear in DASH manifests. `ALL` includes all
    /// non-implicit SCTE-35 events. `MATCHES_FILTER` includes only events whose
    /// type matches the configured `ScteFilter`.
    ///
    /// If you don't specify a value, the default is `ALL`.
    scte_in_manifests: ?ScteInManifests = null,

    pub const json_field_names = .{
        .ad_marker_dash = "AdMarkerDash",
        .scte_in_manifests = "ScteInManifests",
    };
};
