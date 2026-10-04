const DiffChange = @import("diff_change.zig").DiffChange;

/// A contiguous run of changed lines from a blob diff, together with any
/// surrounding
/// unchanged context lines. Hunks are returned in order from the start of the
/// file to the
/// end. Adjacent or overlapping hunks are merged into a single hunk in the
/// response.
pub const DiffHunk = struct {
    /// The number of lines from the after blob covered by this hunk, including any
    /// context
    /// lines.
    after_line_count: ?i32 = null,

    /// The 1-based line number in the after blob where this hunk begins. When the
    /// hunk
    /// consists entirely of deletions, `afterLineCount` is
    /// `0`.
    after_start_line: ?i32 = null,

    /// The number of lines from the before blob covered by this hunk, including any
    /// context lines.
    before_line_count: ?i32 = null,

    /// The 1-based line number in the before blob where this hunk begins. When the
    /// hunk
    /// consists entirely of additions, `beforeLineCount` is
    /// `0`.
    before_start_line: ?i32 = null,

    /// An ordered list of line-level changes that make up this hunk. Each entry
    /// indicates
    /// whether the line is unchanged context, an addition, or a deletion.
    changes: ?[]const DiffChange = null,

    pub const json_field_names = .{
        .after_line_count = "afterLineCount",
        .after_start_line = "afterStartLine",
        .before_line_count = "beforeLineCount",
        .before_start_line = "beforeStartLine",
        .changes = "changes",
    };
};
