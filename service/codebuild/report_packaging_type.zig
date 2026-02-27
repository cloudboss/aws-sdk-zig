pub const ReportPackagingType = enum {
    zip,
    none,

    pub const json_field_names = .{
        .zip = "ZIP",
        .none = "NONE",
    };
};
