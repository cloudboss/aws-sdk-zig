pub const EmvMajorKeyDerivationMode = enum {
    emv_option_a,
    emv_option_b,

    pub const json_field_names = .{
        .emv_option_a = "EMV_OPTION_A",
        .emv_option_b = "EMV_OPTION_B",
    };
};
