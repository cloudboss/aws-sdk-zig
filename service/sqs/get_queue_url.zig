const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetQueueUrlInput = struct {
    /// (Required) The name of the queue for which you want to fetch the URL. The
    /// name can be
    /// up to 80 characters long and can include alphanumeric characters, hyphens
    /// (-), and
    /// underscores (_). Queue URLs and names are case-sensitive.
    queue_name: []const u8,

    /// (Optional) The Amazon Web Services account ID of the account that created
    /// the queue. This is only
    /// required when you are attempting to access a queue owned by another
    /// Amazon Web Services account.
    queue_owner_aws_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .queue_name = "QueueName",
        .queue_owner_aws_account_id = "QueueOwnerAWSAccountId",
    };
};

pub const GetQueueUrlOutput = struct {
    /// The URL of the queue.
    queue_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .queue_url = "QueueUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueueUrlInput, options: CallOptions) !GetQueueUrlOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueueUrlInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSQS.GetQueueUrl");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueueUrlOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetQueueUrlOutput, body, allocator);
}
