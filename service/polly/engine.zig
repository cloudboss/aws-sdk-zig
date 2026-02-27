pub const Engine = enum {
    standard,
    neural,
    long_form,
    generative,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .neural = "NEURAL",
        .long_form = "LONG_FORM",
        .generative = "GENERATIVE",
    };
};
