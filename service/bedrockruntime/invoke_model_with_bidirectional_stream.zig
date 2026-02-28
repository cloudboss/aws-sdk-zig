const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

const InvokeModelWithBidirectionalStreamInput = @import("invoke_model_with_bidirectional_stream_request.zig").InvokeModelWithBidirectionalStreamRequest;

const InvokeModelWithBidirectionalStreamOutput = @import("invoke_model_with_bidirectional_stream_response.zig").InvokeModelWithBidirectionalStreamResponse;

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeModelWithBidirectionalStreamInput, options: Options) !InvokeModelWithBidirectionalStreamOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    // Requires HTTP/2 bidirectional streaming
    return error.EventStreamNotSupported;
}
