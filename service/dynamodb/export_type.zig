pub const ExportType = enum {
    full_export,
    incremental_export,

    pub const json_field_names = .{
        .full_export = "FULL_EXPORT",
        .incremental_export = "INCREMENTAL_EXPORT",
    };
};
