pub const CisReportFormat = enum {
    pdf,
    csv,

    pub const json_field_names = .{
        .pdf = "PDF",
        .csv = "CSV",
    };
};
