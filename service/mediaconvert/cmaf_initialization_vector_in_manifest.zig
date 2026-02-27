/// When you use DRM with CMAF outputs, choose whether the service writes the
/// 128-bit encryption initialization vector in the HLS and DASH manifests.
pub const CmafInitializationVectorInManifest = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
