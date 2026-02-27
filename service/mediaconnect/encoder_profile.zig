pub const EncoderProfile = enum {
    main,
    high,

    pub const json_field_names = .{
        .main = "main",
        .high = "high",
    };
};
