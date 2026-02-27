pub const UntagResourceRequest = struct {
    /// The report name of the report definition that tags are to be disassociated
    /// from.
    report_name: []const u8,

    /// The tags to be disassociated from the report definition resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .report_name = "ReportName",
        .tag_keys = "TagKeys",
    };
};
