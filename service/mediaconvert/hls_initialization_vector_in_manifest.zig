/// The Initialization Vector is a 128-bit number used in conjunction with the
/// key for encrypting blocks. If set to INCLUDE, Initialization Vector is
/// listed in the manifest. Otherwise Initialization Vector is not in the
/// manifest.
pub const HlsInitializationVectorInManifest = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
