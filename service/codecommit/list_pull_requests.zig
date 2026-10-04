const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PullRequestStatusEnum = @import("pull_request_status_enum.zig").PullRequestStatusEnum;

pub const ListPullRequestsInput = struct {
    /// Optional. The Amazon Resource Name (ARN) of the user who created the pull
    /// request. If used, this filters the results
    /// to pull requests created by that user.
    author_arn: ?[]const u8 = null,

    /// A non-zero, non-negative integer used to limit the number of returned
    /// results.
    max_results: ?i32 = null,

    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the
    /// results.
    next_token: ?[]const u8 = null,

    /// Optional. The status of the pull request. If used, this refines the results
    /// to the pull requests that match the specified status.
    pull_request_status: ?PullRequestStatusEnum = null,

    /// The name of the repository for which you want to list pull requests.
    repository_name: []const u8,

    pub const json_field_names = .{
        .author_arn = "authorArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .pull_request_status = "pullRequestStatus",
        .repository_name = "repositoryName",
    };
};

pub const ListPullRequestsOutput = struct {
    /// An enumeration token that allows the operation to batch the next results of
    /// the operation.
    next_token: ?[]const u8 = null,

    /// The system-generated IDs of the pull requests.
    pull_request_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .pull_request_ids = "pullRequestIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPullRequestsInput, options: CallOptions) !ListPullRequestsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPullRequestsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.ListPullRequests");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPullRequestsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListPullRequestsOutput, body, allocator);
}
