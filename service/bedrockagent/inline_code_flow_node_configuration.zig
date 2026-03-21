const SupportedLanguages = @import("supported_languages.zig").SupportedLanguages;

/// Contains configurations for an inline code node in your flow. Inline code
/// nodes let you write and execute code directly within your flow, enabling
/// data transformations, custom logic, and integrations without needing an
/// external Lambda function.
pub const InlineCodeFlowNodeConfiguration = struct {
    /// The code that's executed in your inline code node. The code can access input
    /// data from previous nodes in the flow, perform operations on that data, and
    /// produce output that can be used by other nodes in your flow.
    ///
    /// The code must be valid in the programming `language` that you specify.
    code: []const u8 = "",

    /// The programming language used by your inline code node.
    ///
    /// The code must be valid in the programming `language` that you specify.
    /// Currently, only Python 3 (`Python_3`) is supported.
    language: SupportedLanguages = .python_3,

    pub const json_field_names = .{
        .code = "code",
        .language = "language",
    };
};
