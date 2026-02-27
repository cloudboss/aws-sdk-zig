pub const OverwriteOption = enum {
    create_new_report,
    overwrite_report,

    pub const json_field_names = .{
        .create_new_report = "CREATE_NEW_REPORT",
        .overwrite_report = "OVERWRITE_REPORT",
    };
};
