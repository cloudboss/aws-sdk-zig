const LineTerminator = @import("line_terminator.zig").LineTerminator;
const WrapFormat = @import("wrap_format.zig").WrapFormat;

/// Contains options for wrapping (line folding) in X12 EDI files. Wrapping
/// controls how long lines are handled in the EDI output.
pub const WrapOptions = struct {
    /// Specifies the maximum length of a line before wrapping occurs. This value is
    /// used when `wrapBy` is set to `LINE_LENGTH`.
    line_length: ?i32,

    /// Specifies the character sequence used to terminate lines when wrapping.
    /// Valid values:
    ///
    /// * `CRLF`: carriage return and line feed
    /// * `LF`: line feed)
    /// * `CR`: carriage return
    line_terminator: ?LineTerminator,

    /// Specifies the method used for wrapping lines in the EDI output. Valid
    /// values:
    ///
    /// * `SEGMENT`: Wraps by segment.
    /// * `ONE_LINE`: Indicates that the entire content is on a single line.
    ///
    /// When you specify `ONE_LINE`, do not provide either the line length nor the
    /// line terminator value.
    /// * `LINE_LENGTH`: Wraps by character count, as specified by `lineLength`
    ///   value.
    wrap_by: WrapFormat,

    pub const json_field_names = .{
        .line_length = "lineLength",
        .line_terminator = "lineTerminator",
        .wrap_by = "wrapBy",
    };
};
