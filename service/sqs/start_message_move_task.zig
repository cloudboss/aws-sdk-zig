const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartMessageMoveTaskInput = struct {
    /// The ARN of the queue that receives the moved messages. You can use this
    /// field to
    /// specify the destination queue where you would like to redrive messages. If
    /// this field is
    /// left blank, the messages will be redriven back to their respective original
    /// source
    /// queues.
    destination_arn: ?[]const u8 = null,

    /// The number of messages to be moved per second (the message movement rate).
    /// You can use
    /// this field to define a fixed message movement rate. The maximum value for
    /// messages per
    /// second is 500. If this field is left blank, the system will optimize the
    /// rate based on
    /// the queue message backlog size, which may vary throughout the duration of
    /// the message
    /// movement task.
    max_number_of_messages_per_second: ?i32 = null,

    /// The ARN of the queue that contains the messages to be moved to another
    /// queue.
    /// Currently, only ARNs of dead-letter queues (DLQs) whose sources are other
    /// Amazon SQS queues
    /// are accepted. DLQs whose sources are non-SQS queues, such as Lambda or
    /// Amazon SNS topics, are
    /// not currently supported.
    source_arn: []const u8,

    pub const json_field_names = .{
        .destination_arn = "DestinationArn",
        .max_number_of_messages_per_second = "MaxNumberOfMessagesPerSecond",
        .source_arn = "SourceArn",
    };
};

pub const StartMessageMoveTaskOutput = struct {
    /// An identifier associated with a message movement task. You can use this
    /// identifier to
    /// cancel a specified message movement task using the `CancelMessageMoveTask`
    /// action.
    task_handle: ?[]const u8 = null,

    pub const json_field_names = .{
        .task_handle = "TaskHandle",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMessageMoveTaskInput, options: CallOptions) !StartMessageMoveTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMessageMoveTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSQS.StartMessageMoveTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMessageMoveTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartMessageMoveTaskOutput, body, allocator);
}
