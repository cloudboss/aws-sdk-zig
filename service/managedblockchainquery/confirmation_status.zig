pub const ConfirmationStatus = enum {
    final,
    nonfinal,

    pub const json_field_names = .{
        .final = "FINAL",
        .nonfinal = "NONFINAL",
    };
};
