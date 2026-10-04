const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OverrideStatus = @import("override_status.zig").OverrideStatus;

pub const OverridePullRequestApprovalRulesInput = struct {
    /// Whether you want to set aside approval rule requirements for the pull
    /// request (OVERRIDE) or revoke a previous override and apply
    /// approval rule requirements (REVOKE). REVOKE status is not stored.
    override_status: OverrideStatus,

    /// The system-generated ID of the pull request for which you want to override
    /// all
    /// approval rule requirements. To get this information, use
    /// GetPullRequest.
    pull_request_id: []const u8,

    /// The system-generated ID of the most recent revision of the pull request. You
    /// cannot override approval rules for anything but the most recent revision of
    /// a pull request.
    /// To get the revision ID, use GetPullRequest.
    revision_id: []const u8,

    pub const json_field_names = .{
        .override_status = "overrideStatus",
        .pull_request_id = "pullRequestId",
        .revision_id = "revisionId",
    };
};

pub const OverridePullRequestApprovalRulesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: OverridePullRequestApprovalRulesInput, options: CallOptions) !OverridePullRequestApprovalRulesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: OverridePullRequestApprovalRulesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.OverridePullRequestApprovalRules");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !OverridePullRequestApprovalRulesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
