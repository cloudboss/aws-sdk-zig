const CodeContentDescription = @import("code_content_description.zig").CodeContentDescription;
const CodeContentType = @import("code_content_type.zig").CodeContentType;

/// Describes code configuration for an application.
pub const ApplicationCodeConfigurationDescription = struct {
    /// Describes details about the location and format of the application code.
    code_content_description: ?CodeContentDescription,

    /// Specifies whether the code content is in text or zip format.
    code_content_type: CodeContentType,

    pub const json_field_names = .{
        .code_content_description = "CodeContentDescription",
        .code_content_type = "CodeContentType",
    };
};
