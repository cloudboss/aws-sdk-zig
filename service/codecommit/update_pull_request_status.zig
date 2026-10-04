const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PullRequestStatusEnum = @import("pull_request_status_enum.zig").PullRequestStatusEnum;
const PullRequest = @import("pull_request.zig").PullRequest;

pub const UpdatePullRequestStatusInput = struct {
    /// The system-generated ID of the pull request. To get this ID, use
    /// ListPullRequests.
    pull_request_id: []const u8,

    /// The status of the pull request. The only valid operations are to update the
    /// status
    /// from `OPEN` to `OPEN`, `OPEN` to `CLOSED` or
    /// from `CLOSED` to `CLOSED`.
    pull_request_status: PullRequestStatusEnum,

    pub const json_field_names = .{
        .pull_request_id = "pullRequestId",
        .pull_request_status = "pullRequestStatus",
    };
};

pub const UpdatePullRequestStatusOutput = struct {
    /// Information about the pull request.
    pull_request: ?PullRequest = null,

    pub const json_field_names = .{
        .pull_request = "pullRequest",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePullRequestStatusInput, options: CallOptions) !UpdatePullRequestStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePullRequestStatusInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.UpdatePullRequestStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePullRequestStatusOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdatePullRequestStatusOutput, body, allocator);
}
