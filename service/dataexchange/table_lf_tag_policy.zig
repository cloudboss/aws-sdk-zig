const LFTag = @import("lf_tag.zig").LFTag;

/// The LF-tag policy for a table resource.
pub const TableLFTagPolicy = struct {
    /// A list of LF-tag conditions that apply to table resources.
    expression: []const LFTag,

    pub const json_field_names = .{
        .expression = "Expression",
    };
};
