const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotifyWorkersFailureStatus = @import("notify_workers_failure_status.zig").NotifyWorkersFailureStatus;

pub const NotifyWorkersInput = struct {
    /// The text of the email message to send. Can include up to
    /// 4,096 characters
    message_text: []const u8,

    /// The subject line of the email message to send. Can include up
    /// to 200 characters.
    subject: []const u8,

    /// A list of Worker IDs you wish to notify. You
    /// can notify upto
    /// 100 Workers at a time.
    worker_ids: []const []const u8,

    pub const json_field_names = .{
        .message_text = "MessageText",
        .subject = "Subject",
        .worker_ids = "WorkerIds",
    };
};

pub const NotifyWorkersOutput = struct {
    /// When MTurk sends notifications to the list of Workers, it
    /// returns back any failures it encounters in this list of
    /// NotifyWorkersFailureStatus objects.
    notify_workers_failure_statuses: ?[]const NotifyWorkersFailureStatus = null,

    pub const json_field_names = .{
        .notify_workers_failure_statuses = "NotifyWorkersFailureStatuses",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: NotifyWorkersInput, options: CallOptions) !NotifyWorkersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mturk-requester", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: NotifyWorkersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mturk-requester", "MTurk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.NotifyWorkers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !NotifyWorkersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(NotifyWorkersOutput, body, allocator);
}
