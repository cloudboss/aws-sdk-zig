/// Information about the details of a merge hunk that contains a conflict in a
/// merge or pull request operation.
pub const MergeHunkDetail = struct {
    /// The end position of the hunk in the merge result.
    end_line: ?i32,

    /// The base-64 encoded content of the hunk merged region that might contain a
    /// conflict.
    hunk_content: ?[]const u8,

    /// The start position of the hunk in the merge result.
    start_line: ?i32,

    pub const json_field_names = .{
        .end_line = "endLine",
        .hunk_content = "hunkContent",
        .start_line = "startLine",
    };
};
