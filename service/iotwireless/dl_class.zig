/// DlClass for LoRaWAM, valid values are ClassB and ClassC.
pub const DlClass = enum {
    class_b,
    class_c,

    pub const json_field_names = .{
        .class_b = "ClassB",
        .class_c = "ClassC",
    };
};
