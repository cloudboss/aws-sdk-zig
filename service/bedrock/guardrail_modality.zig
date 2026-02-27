pub const GuardrailModality = enum {
    text,
    image,

    pub const json_field_names = .{
        .text = "TEXT",
        .image = "IMAGE",
    };
};
