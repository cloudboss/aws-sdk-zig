const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FlowInput = @import("flow_input.zig").FlowInput;
const ModelPerformanceConfiguration = @import("model_performance_configuration.zig").ModelPerformanceConfiguration;
const FlowResponseStream = @import("flow_response_stream.zig").FlowResponseStream;

pub const InvokeFlowInput = struct {
    /// Specifies whether to return the trace for the flow or not. Traces track
    /// inputs and outputs for nodes in the flow. For more information, see [Track
    /// each step in your prompt flow by viewing its trace in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
    enable_trace: ?bool = null,

    /// The unique identifier for the current flow execution. If you don't provide a
    /// value, Amazon Bedrock creates the identifier for you.
    execution_id: ?[]const u8 = null,

    /// The unique identifier of the flow alias.
    flow_alias_identifier: []const u8,

    /// The unique identifier of the flow.
    flow_identifier: []const u8,

    /// A list of objects, each containing information about an input into the flow.
    inputs: []const FlowInput,

    /// Model performance settings for the request.
    model_performance_configuration: ?ModelPerformanceConfiguration = null,

    pub const json_field_names = .{
        .enable_trace = "enableTrace",
        .execution_id = "executionId",
        .flow_alias_identifier = "flowAliasIdentifier",
        .flow_identifier = "flowIdentifier",
        .inputs = "inputs",
        .model_performance_configuration = "modelPerformanceConfiguration",
    };
};

pub const InvokeFlowOutput = struct {
    /// The unique identifier for the current flow execution.
    execution_id: ?[]const u8 = null,

    /// The output of the flow, returned as a stream. If there's an error, the error
    /// is returned.
    response_stream: ?FlowResponseStream = null,

    pub const json_field_names = .{
        .execution_id = "executionId",
        .response_stream = "responseStream",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeFlowInput, options: Options) !InvokeFlowOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
