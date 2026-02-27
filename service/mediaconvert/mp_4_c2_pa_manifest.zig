/// When enabled, a C2PA compliant manifest will be generated, signed and
/// embeded in the output. For more information on C2PA, see
/// https://c2pa.org/specifications/specifications/2.1/index.html
pub const Mp4C2paManifest = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
