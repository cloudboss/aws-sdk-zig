pub const VerifyMode = enum {
    point_in_time_consistent,
    only_files_transferred,
    none,

    pub const json_field_names = .{
        .point_in_time_consistent = "POINT_IN_TIME_CONSISTENT",
        .only_files_transferred = "ONLY_FILES_TRANSFERRED",
        .none = "NONE",
    };
};
