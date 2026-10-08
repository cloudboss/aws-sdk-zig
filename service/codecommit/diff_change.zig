const DiffChangeType = @import("diff_change_type.zig").DiffChangeType;

/// A single line-level entry in a diff hunk. Each `DiffChange` describes one
/// line and its change type: unchanged context, an addition in the after blob,
/// or a
/// deletion from the before blob.
pub const DiffChange = struct {
    /// The 1-based line number in the after blob. This field is omitted for
    /// `DELETE` lines.
    after_line_number: ?i32 = null,

    /// The 1-based line number in the before blob. This field is omitted for
    /// `ADD` lines.
    before_line_number: ?i32 = null,

    /// The text content of the line, without the trailing newline.
    content: ?[]const u8 = null,

    /// The type of change for this line. Possible values:
    ///
    /// * `CONTEXT` – Unchanged line included for surrounding
    /// context.
    ///
    /// * `ADD` – Line added in the after blob.
    ///
    /// * `DELETE` – Line removed from the before blob.
    type: ?DiffChangeType = null,

    pub const json_field_names = .{
        .after_line_number = "afterLineNumber",
        .before_line_number = "beforeLineNumber",
        .content = "content",
        .type = "type",
    };
};
