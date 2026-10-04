const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SyncConfigurationType = @import("sync_configuration_type.zig").SyncConfigurationType;
const RepositorySyncDefinition = @import("repository_sync_definition.zig").RepositorySyncDefinition;

pub const ListRepositorySyncDefinitionsInput = struct {
    /// The ID of the repository link for the sync definition for which you want to
    /// retrieve information.
    repository_link_id: []const u8,

    /// The sync type of the repository link for the the sync definition for which
    /// you want to retrieve information.
    sync_type: SyncConfigurationType,

    pub const json_field_names = .{
        .repository_link_id = "RepositoryLinkId",
        .sync_type = "SyncType",
    };
};

pub const ListRepositorySyncDefinitionsOutput = struct {
    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the
    /// results.
    next_token: ?[]const u8 = null,

    /// The list of repository sync definitions returned by the request. A
    /// `RepositorySyncDefinition` is a mapping from a repository branch to all the
    /// Amazon Web Services resources that are being synced from that branch.
    repository_sync_definitions: ?[]const RepositorySyncDefinition = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .repository_sync_definitions = "RepositorySyncDefinitions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRepositorySyncDefinitionsInput, options: CallOptions) !ListRepositorySyncDefinitionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRepositorySyncDefinitionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeConnections_20231201.ListRepositorySyncDefinitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRepositorySyncDefinitionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListRepositorySyncDefinitionsOutput, body, allocator);
}
