pub const AttachmentContentTransferEncoding = enum {
    base64,
    quoted_printable,
    seven_bit,

    pub const json_field_names = .{
        .base64 = "BASE64",
        .quoted_printable = "QUOTED_PRINTABLE",
        .seven_bit = "SEVEN_BIT",
    };
};
