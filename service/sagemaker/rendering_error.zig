/// A description of an error that occurred while rendering the template.
pub const RenderingError = struct {
    /// A unique identifier for a specific class of errors.
    code: []const u8,

    /// A human-readable message describing the error.
    message: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
