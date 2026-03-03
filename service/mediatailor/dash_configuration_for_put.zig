const OriginManifestType = @import("origin_manifest_type.zig").OriginManifestType;

/// The configuration for DASH PUT operations.
pub const DashConfigurationForPut = struct {
    /// The setting that controls whether MediaTailor includes the Location tag in
    /// DASH manifests. MediaTailor populates the Location tag with the URL for
    /// manifest update requests, to be used by players that don't support sticky
    /// redirects. Disable this if you have CDN routing rules set up for accessing
    /// MediaTailor manifests, and you are either using client-side reporting or
    /// your players support sticky HTTP redirects. Valid values are `DISABLED` and
    /// `EMT_DEFAULT`. The `EMT_DEFAULT` setting enables the inclusion of the tag
    /// and is the default value.
    mpd_location: ?[]const u8 = null,

    /// The setting that controls whether MediaTailor handles manifests from the
    /// origin server as multi-period manifests or single-period manifests. If your
    /// origin server produces single-period manifests, set this to `SINGLE_PERIOD`.
    /// The default setting is `MULTI_PERIOD`. For multi-period manifests, omit this
    /// setting or set it to `MULTI_PERIOD`.
    origin_manifest_type: ?OriginManifestType = null,

    pub const json_field_names = .{
        .mpd_location = "MpdLocation",
        .origin_manifest_type = "OriginManifestType",
    };
};
