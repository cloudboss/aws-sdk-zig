pub const PinBlockPaddingType = enum {
    no_padding,
    iso_iec_7816_4,

    pub const json_field_names = .{
        .no_padding = "NO_PADDING",
        .iso_iec_7816_4 = "ISO_IEC_7816_4",
    };
};
