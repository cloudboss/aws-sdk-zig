const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeMessageVisibilityBatchRequestEntry = @import("change_message_visibility_batch_request_entry.zig").ChangeMessageVisibilityBatchRequestEntry;
const BatchResultErrorEntry = @import("batch_result_error_entry.zig").BatchResultErrorEntry;
const ChangeMessageVisibilityBatchResultEntry = @import("change_message_visibility_batch_result_entry.zig").ChangeMessageVisibilityBatchResultEntry;

pub const ChangeMessageVisibilityBatchInput = struct {
    /// Lists the receipt handles of the messages for which the visibility timeout
    /// must be
    /// changed.
    entries: []const ChangeMessageVisibilityBatchRequestEntry,

    /// The URL of the Amazon SQS queue whose messages' visibility is changed.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    pub const json_field_names = .{
        .entries = "Entries",
        .queue_url = "QueueUrl",
    };
};

pub const ChangeMessageVisibilityBatchOutput = struct {
    /// A list of `
    /// BatchResultErrorEntry
    /// ` items.
    failed: ?[]const BatchResultErrorEntry = null,

    /// A list of `
    /// ChangeMessageVisibilityBatchResultEntry
    /// `
    /// items.
    successful: ?[]const ChangeMessageVisibilityBatchResultEntry = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .successful = "Successful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChangeMessageVisibilityBatchInput, options: CallOptions) !ChangeMessageVisibilityBatchOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ChangeMessageVisibilityBatchInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSQS.ChangeMessageVisibilityBatch");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ChangeMessageVisibilityBatchOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ChangeMessageVisibilityBatchOutput, body, allocator);
}
