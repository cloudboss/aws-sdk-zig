pub const ReportType = enum {
    finding,
    full,

    pub const json_field_names = .{
        .finding = "FINDING",
        .full = "FULL",
    };
};
