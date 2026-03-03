const SyntaxToken = @import("syntax_token.zig").SyntaxToken;

/// The result of calling the operation. The
/// operation returns one object that is successfully processed by the
/// operation.
pub const BatchDetectSyntaxItemResult = struct {
    /// The zero-based index of the document in the input list.
    index: ?i32 = null,

    /// The syntax tokens for the words in the document, one token for each word.
    syntax_tokens: ?[]const SyntaxToken = null,

    pub const json_field_names = .{
        .index = "Index",
        .syntax_tokens = "SyntaxTokens",
    };
};
