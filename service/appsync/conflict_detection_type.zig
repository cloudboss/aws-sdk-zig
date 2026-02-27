pub const ConflictDetectionType = enum {
    version,
    none,

    pub const json_field_names = .{
        .version = "VERSION",
        .none = "NONE",
    };
};
