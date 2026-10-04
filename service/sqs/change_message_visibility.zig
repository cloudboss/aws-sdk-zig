const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ChangeMessageVisibilityInput = struct {
    /// The URL of the Amazon SQS queue whose message's visibility is changed.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    /// The receipt handle associated with the message, whose visibility timeout is
    /// changed.
    /// This parameter is returned by the `
    /// ReceiveMessage
    /// `
    /// action.
    receipt_handle: []const u8,

    /// The new value for the message's visibility timeout (in seconds). Values
    /// range:
    /// `0` to `43200`. Maximum: 12 hours.
    visibility_timeout: i32,

    pub const json_field_names = .{
        .queue_url = "QueueUrl",
        .receipt_handle = "ReceiptHandle",
        .visibility_timeout = "VisibilityTimeout",
    };
};

pub const ChangeMessageVisibilityOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChangeMessageVisibilityInput, options: CallOptions) !ChangeMessageVisibilityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sqs", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ChangeMessageVisibilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sqs", "SQS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSQS.ChangeMessageVisibility");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ChangeMessageVisibilityOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
