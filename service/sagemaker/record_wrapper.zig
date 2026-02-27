pub const RecordWrapper = enum {
    none,
    recordio,

    pub const json_field_names = .{
        .none = "NONE",
        .recordio = "RECORDIO",
    };
};
