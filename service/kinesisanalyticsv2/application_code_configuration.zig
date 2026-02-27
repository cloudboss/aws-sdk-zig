const CodeContent = @import("code_content.zig").CodeContent;
const CodeContentType = @import("code_content_type.zig").CodeContentType;

/// Describes code configuration for an application.
pub const ApplicationCodeConfiguration = struct {
    /// The location and type of the application code.
    code_content: ?CodeContent,

    /// Specifies whether the code content is in text or zip format.
    code_content_type: CodeContentType,

    pub const json_field_names = .{
        .code_content = "CodeContent",
        .code_content_type = "CodeContentType",
    };
};
