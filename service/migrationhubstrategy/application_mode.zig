pub const ApplicationMode = enum {
    all,
    known,
    unknown,

    pub const json_field_names = .{
        .all = "ALL",
        .known = "KNOWN",
        .unknown = "UNKNOWN",
    };
};
