/// Embedded Convert608 To708
pub const EmbeddedConvert608To708 = enum {
    disabled,
    upconvert,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .upconvert = "UPCONVERT",
    };
};
