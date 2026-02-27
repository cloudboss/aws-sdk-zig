pub const ReportFileFormat = enum {
    html,
    pdf,

    pub const json_field_names = .{
        .html = "HTML",
        .pdf = "PDF",
    };
};
