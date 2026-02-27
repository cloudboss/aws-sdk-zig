/// The line of code where a finding was detected.
pub const CodeLine = struct {
    /// The code that contains a vulnerability.
    content: ?[]const u8,

    /// The code line number.
    number: ?i32,

    pub const json_field_names = .{
        .content = "content",
        .number = "number",
    };
};
