const LFTag = @import("lf_tag.zig").LFTag;

/// The LF-tag policy for database resources.
pub const DatabaseLFTagPolicy = struct {
    /// A list of LF-tag conditions that apply to database resources.
    expression: []const LFTag,

    pub const json_field_names = .{
        .expression = "Expression",
    };
};
