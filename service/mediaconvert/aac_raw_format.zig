/// Enables LATM/LOAS AAC output. Note that if you use LATM/LOAS AAC in an
/// output, you must choose "No container" for the output container.
pub const AacRawFormat = enum {
    latm_loas,
    none,

    pub const json_field_names = .{
        .latm_loas = "LATM_LOAS",
        .none = "NONE",
    };
};
