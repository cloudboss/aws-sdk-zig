const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SyncConfigurationType = @import("sync_configuration_type.zig").SyncConfigurationType;
const RepositorySyncAttempt = @import("repository_sync_attempt.zig").RepositorySyncAttempt;

pub const GetRepositorySyncStatusInput = struct {
    /// The branch of the repository link for the requested repository sync status.
    branch: []const u8,

    /// The repository link ID for the requested repository sync status.
    repository_link_id: []const u8,

    /// The sync type of the requested sync status.
    sync_type: SyncConfigurationType,

    pub const json_field_names = .{
        .branch = "Branch",
        .repository_link_id = "RepositoryLinkId",
        .sync_type = "SyncType",
    };
};

pub const GetRepositorySyncStatusOutput = struct {
    /// The status of the latest sync returned for a specified repository and
    /// branch.
    latest_sync: ?RepositorySyncAttempt = null,

    pub const json_field_names = .{
        .latest_sync = "LatestSync",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRepositorySyncStatusInput, options: CallOptions) !GetRepositorySyncStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeconnections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRepositorySyncStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeconnections", "CodeConnections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeConnections_20231201.GetRepositorySyncStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRepositorySyncStatusOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetRepositorySyncStatusOutput, body, allocator);
}
