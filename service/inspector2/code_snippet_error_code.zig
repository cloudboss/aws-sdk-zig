pub const CodeSnippetErrorCode = enum {
    internal_error,
    access_denied,
    code_snippet_not_found,
    invalid_input,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .access_denied = "ACCESS_DENIED",
        .code_snippet_not_found = "CODE_SNIPPET_NOT_FOUND",
        .invalid_input = "INVALID_INPUT",
    };
};
