const ProtectedQueryOutput = @import("protected_query_output.zig").ProtectedQueryOutput;

/// Details about the query results.
pub const ProtectedQueryResult = struct {
    /// The output of the protected query.
    output: ProtectedQueryOutput,

    pub const json_field_names = .{
        .output = "output",
    };
};
