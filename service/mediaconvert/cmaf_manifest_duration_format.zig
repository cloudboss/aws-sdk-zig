/// Indicates whether the output manifest should use floating point values for
/// segment duration.
pub const CmafManifestDurationFormat = enum {
    floating_point,
    integer,

    pub const json_field_names = .{
        .floating_point = "FLOATING_POINT",
        .integer = "INTEGER",
    };
};
