/// Describes the location of a statement within a source document using line
/// numbers.
pub const AutomatedReasoningPolicyStatementLocation = struct {
    /// The line numbers in the source document where this statement appears.
    lines: []const i32,

    pub const json_field_names = .{
        .lines = "lines",
    };
};
