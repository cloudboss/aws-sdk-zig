const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetPullRequestOverrideStateInput = struct {
    /// The ID of the pull request for which you want to get information about
    /// whether approval rules have been set aside (overridden).
    pull_request_id: []const u8,

    /// The system-generated ID of the revision for the pull request. To retrieve
    /// the most
    /// recent revision ID, use
    /// GetPullRequest.
    revision_id: []const u8,

    pub const json_field_names = .{
        .pull_request_id = "pullRequestId",
        .revision_id = "revisionId",
    };
};

pub const GetPullRequestOverrideStateOutput = struct {
    /// A Boolean value that indicates whether a pull request has had its rules set
    /// aside (TRUE) or whether all approval rules still apply (FALSE).
    overridden: ?bool = null,

    /// The Amazon Resource Name (ARN) of the user or identity that overrode the
    /// rules and their requirements for the pull request.
    overrider: ?[]const u8 = null,

    pub const json_field_names = .{
        .overridden = "overridden",
        .overrider = "overrider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPullRequestOverrideStateInput, options: CallOptions) !GetPullRequestOverrideStateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPullRequestOverrideStateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.GetPullRequestOverrideState");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPullRequestOverrideStateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPullRequestOverrideStateOutput, body, allocator);
}
