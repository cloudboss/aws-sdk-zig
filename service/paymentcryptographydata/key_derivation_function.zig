pub const KeyDerivationFunction = enum {
    nist_sp800,
    ansi_x963,

    pub const json_field_names = .{
        .nist_sp800 = "NIST_SP800",
        .ansi_x963 = "ANSI_X963",
    };
};
