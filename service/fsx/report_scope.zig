pub const ReportScope = enum {
    failed_files_only,

    pub const json_field_names = .{
        .failed_files_only = "FAILED_FILES_ONLY",
    };
};
