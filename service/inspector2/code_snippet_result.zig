const CodeLine = @import("code_line.zig").CodeLine;
const SuggestedFix = @import("suggested_fix.zig").SuggestedFix;

/// Contains information on a code snippet retrieved by Amazon Inspector from a
/// code vulnerability
/// finding.
pub const CodeSnippetResult = struct {
    /// Contains information on the retrieved code snippet.
    code_snippet: ?[]const CodeLine = null,

    /// The line number of the last line of a code snippet.
    end_line: ?i32 = null,

    /// The ARN of a finding that the code snippet is associated with.
    finding_arn: ?[]const u8 = null,

    /// The line number of the first line of a code snippet.
    start_line: ?i32 = null,

    /// Details of a suggested code fix.
    suggested_fixes: ?[]const SuggestedFix = null,

    pub const json_field_names = .{
        .code_snippet = "codeSnippet",
        .end_line = "endLine",
        .finding_arn = "findingArn",
        .start_line = "startLine",
        .suggested_fixes = "suggestedFixes",
    };
};
