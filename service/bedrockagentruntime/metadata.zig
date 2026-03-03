const Usage = @import("usage.zig").Usage;

/// Provides information about the execution process for different types of
/// invocations, such as model invocation, knowledge base invocation, agent
/// collaborator invocation, guardrail invocation, and code interpreter
/// Invocation.
pub const Metadata = struct {
    /// A unique identifier associated with the downstream invocation. This ID can
    /// be used for tracing, debugging, and identifying specific invocations in
    /// customer logs or systems.
    client_request_id: ?[]const u8 = null,

    /// In the final response, `endTime` is the end time of the agent invocation
    /// operation.
    end_time: ?i64 = null,

    /// The total time it took for the agent to complete execution. This field is
    /// only set for the final response.
    operation_total_time_ms: ?i64 = null,

    /// In the final response, `startTime` is the start time of the agent invocation
    /// operation.
    start_time: ?i64 = null,

    /// The total execution time for the specific invocation being processed (model,
    /// knowledge base, guardrail, agent collaborator, or code interpreter). It
    /// represents how long the individual invocation took.
    total_time_ms: ?i64 = null,

    /// Specific to model invocation and contains details about the usage of a
    /// foundation model.
    usage: ?Usage = null,

    pub const json_field_names = .{
        .client_request_id = "clientRequestId",
        .end_time = "endTime",
        .operation_total_time_ms = "operationTotalTimeMs",
        .start_time = "startTime",
        .total_time_ms = "totalTimeMs",
        .usage = "usage",
    };
};
