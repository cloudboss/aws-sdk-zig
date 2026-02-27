pub const LogType = enum {
    all,
    error_summary,

    pub const json_field_names = .{
        .all = "ALL",
        .error_summary = "ERROR_SUMMARY",
    };
};
