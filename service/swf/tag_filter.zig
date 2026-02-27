/// Used to filter the workflow executions in visibility APIs based on a tag.
pub const TagFilter = struct {
    /// Specifies the tag that must be associated with the execution for it to meet
    /// the filter
    /// criteria.
    ///
    /// Tags may only contain unicode letters, digits, whitespace, or these symbols:
    /// `_ . : / = + - @`.
    tag: []const u8,

    pub const json_field_names = .{
        .tag = "tag",
    };
};
