pub const ReportFormat = enum {
    pdf,
    json,

    pub const json_field_names = .{
        .pdf = "PDF",
        .json = "JSON",
    };
};
