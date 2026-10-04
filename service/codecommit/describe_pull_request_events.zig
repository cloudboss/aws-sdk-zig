const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PullRequestEventType = @import("pull_request_event_type.zig").PullRequestEventType;
const PullRequestEvent = @import("pull_request_event.zig").PullRequestEvent;

pub const DescribePullRequestEventsInput = struct {
    /// The Amazon Resource Name (ARN) of the user whose actions resulted in the
    /// event.
    /// Examples include updating the pull request with more commits or changing the
    /// status of a
    /// pull request.
    actor_arn: ?[]const u8 = null,

    /// A non-zero, non-negative integer used to limit the number of returned
    /// results.
    /// The default is 100 events, which is also the maximum number of events that
    /// can be returned in a result.
    max_results: ?i32 = null,

    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the
    /// results.
    next_token: ?[]const u8 = null,

    /// Optional. The pull request event type about which you want to return
    /// information.
    pull_request_event_type: ?PullRequestEventType = null,

    /// The system-generated ID of the pull request. To get this ID, use
    /// ListPullRequests.
    pull_request_id: []const u8,

    pub const json_field_names = .{
        .actor_arn = "actorArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .pull_request_event_type = "pullRequestEventType",
        .pull_request_id = "pullRequestId",
    };
};

pub const DescribePullRequestEventsOutput = struct {
    /// An enumeration token that can be used in a request to return the next batch
    /// of the results.
    next_token: ?[]const u8 = null,

    /// Information about the pull request events.
    pull_request_events: ?[]const PullRequestEvent = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .pull_request_events = "pullRequestEvents",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePullRequestEventsInput, options: CallOptions) !DescribePullRequestEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecommit", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePullRequestEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.DescribePullRequestEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePullRequestEventsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribePullRequestEventsOutput, body, allocator);
}
