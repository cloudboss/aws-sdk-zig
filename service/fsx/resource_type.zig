pub const ResourceType = enum {
    file_system,
    volume,

    pub const json_field_names = .{
        .file_system = "FILE_SYSTEM",
        .volume = "VOLUME",
    };
};
