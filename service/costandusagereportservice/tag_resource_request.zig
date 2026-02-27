const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The report name of the report definition that tags are to be associated
    /// with.
    report_name: []const u8,

    /// The tags to be assigned to the report definition resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .report_name = "ReportName",
        .tags = "Tags",
    };
};
