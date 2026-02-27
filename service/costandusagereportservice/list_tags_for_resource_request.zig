pub const ListTagsForResourceRequest = struct {
    /// The report name of the report definition that tags are to be returned for.
    report_name: []const u8,

    pub const json_field_names = .{
        .report_name = "ReportName",
    };
};
