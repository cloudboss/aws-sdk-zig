pub const ResourceType = enum {
    jar,
    file,
    archive,

    pub const json_field_names = .{
        .jar = "JAR",
        .file = "FILE",
        .archive = "ARCHIVE",
    };
};
