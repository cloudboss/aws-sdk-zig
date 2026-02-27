pub const UploadAvailability = enum {
    standard,
    streaming,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .streaming = "STREAMING",
    };
};
