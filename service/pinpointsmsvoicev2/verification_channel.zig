pub const VerificationChannel = enum {
    text,
    voice,

    pub const json_field_names = .{
        .text = "TEXT",
        .voice = "VOICE",
    };
};
