pub const GuardrailContentSource = enum {
    input,
    output,

    pub const json_field_names = .{
        .input = "INPUT",
        .output = "OUTPUT",
    };
};
