const ConcurrencyType = @import("concurrency_type.zig").ConcurrencyType;

/// Determines how multiple nodes in a flow can run in parallel. Running nodes
/// concurrently can improve your flow's performance.
pub const FlowAliasConcurrencyConfiguration = struct {
    /// The maximum number of nodes that can be executed concurrently in the flow.
    max_concurrency: ?i32,

    /// The type of concurrency to use for parallel node execution. Specify one of
    /// the following options:
    ///
    /// * `Automatic` - Amazon Bedrock determines which nodes can be executed in
    ///   parallel based on the flow definition and its dependencies.
    /// * `Manual` - You specify which nodes can be executed in parallel.
    type: ConcurrencyType,

    pub const json_field_names = .{
        .max_concurrency = "maxConcurrency",
        .type = "type",
    };
};
