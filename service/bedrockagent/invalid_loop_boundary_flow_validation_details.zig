/// Details about a flow that contains connections that violate loop boundary
/// rules.
pub const InvalidLoopBoundaryFlowValidationDetails = struct {
    /// The name of the connection that violates loop boundary rules.
    connection: []const u8,

    /// The source node of the connection that violates DoWhile loop boundary rules.
    source: []const u8,

    /// The target node of the connection that violates DoWhile loop boundary rules.
    target: []const u8,

    pub const json_field_names = .{
        .connection = "connection",
        .source = "source",
        .target = "target",
    };
};
