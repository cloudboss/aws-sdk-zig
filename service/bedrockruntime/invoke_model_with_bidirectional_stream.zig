const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const InvokeModelWithBidirectionalStreamInput = @import("invoke_model_with_bidirectional_stream_request.zig").InvokeModelWithBidirectionalStreamRequest;

pub const InvokeModelWithBidirectionalStreamOutput = @import("invoke_model_with_bidirectional_stream_response.zig").InvokeModelWithBidirectionalStreamResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeModelWithBidirectionalStreamInput, options: CallOptions) !InvokeModelWithBidirectionalStreamOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    // Requires HTTP/2 bidirectional streaming
    return error.EventStreamNotSupported;
}
