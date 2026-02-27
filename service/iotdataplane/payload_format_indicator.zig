pub const PayloadFormatIndicator = enum {
    unspecified_bytes,
    utf8_data,

    pub const json_field_names = .{
        .unspecified_bytes = "UNSPECIFIED_BYTES",
        .utf8_data = "UTF8_DATA",
    };
};
