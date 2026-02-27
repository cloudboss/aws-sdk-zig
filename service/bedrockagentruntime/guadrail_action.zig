pub const GuadrailAction = enum {
    intervened,
    none,

    pub const json_field_names = .{
        .intervened = "INTERVENED",
        .none = "NONE",
    };
};
