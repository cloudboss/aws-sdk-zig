pub const ConflictDetailLevelTypeEnum = enum {
    file_level,
    line_level,

    pub const json_field_names = .{
        .file_level = "FILE_LEVEL",
        .line_level = "LINE_LEVEL",
    };
};
