/// Represents textual data, plus an optional character set specification.
///
/// By default, the text must be 7-bit ASCII, due to the constraints of the SMTP
/// protocol.
/// If the text must contain any other characters, then you must also specify a
/// character
/// set. Examples include UTF-8, ISO-8859-1, and Shift_JIS.
pub const Content = struct {
    /// The character set of the content.
    charset: ?[]const u8 = null,

    /// The textual data of the content.
    data: []const u8,
};
