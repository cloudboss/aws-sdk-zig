/// Aac Raw Format
pub const AacRawFormat = enum {
    latm_loas,
    none,

    pub const json_field_names = .{
        .latm_loas = "LATM_LOAS",
        .none = "NONE",
    };
};
