/// The code execution output in JSON format.
pub const StatementOutputData = struct {
    /// The code execution output in text format.
    text_plain: ?[]const u8,

    pub const json_field_names = .{
        .text_plain = "TextPlain",
    };
};
