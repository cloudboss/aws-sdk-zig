const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RequestStreamEvent = @import("request_stream_event.zig").RequestStreamEvent;
const ResponseStreamEvent = @import("response_stream_event.zig").ResponseStreamEvent;

pub const InvokeEndpointWithBidirectionalStreamInput = struct {
    /// The request payload stream.
    body: RequestStreamEvent,

    /// The name of the endpoint to invoke.
    endpoint_name: []const u8,

    /// Model invocation path.
    model_invocation_path: ?[]const u8 = null,

    /// Model query string.
    model_query_string: ?[]const u8 = null,

    /// Target variant for the request.
    target_variant: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .endpoint_name = "EndpointName",
        .model_invocation_path = "ModelInvocationPath",
        .model_query_string = "ModelQueryString",
        .target_variant = "TargetVariant",
    };
};

pub const InvokeEndpointWithBidirectionalStreamOutput = struct {
    /// The response payload stream.
    body: ?ResponseStreamEvent = null,

    /// The invoked production variant.
    invoked_production_variant: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .invoked_production_variant = "InvokedProductionVariant",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeEndpointWithBidirectionalStreamInput, options: CallOptions) !InvokeEndpointWithBidirectionalStreamOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    // Requires HTTP/2 bidirectional streaming
    return error.EventStreamNotSupported;
}
