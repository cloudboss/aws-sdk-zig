const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryProvider = @import("repository_provider.zig").RepositoryProvider;
const SyncType = @import("sync_type.zig").SyncType;
const RepositorySyncDefinition = @import("repository_sync_definition.zig").RepositorySyncDefinition;

pub const ListRepositorySyncDefinitionsInput = struct {
    /// A token that indicates the location of the next repository sync definition
    /// in the array of repository sync definitions, after the list of repository
    /// sync definitions previously requested.
    next_token: ?[]const u8 = null,

    /// The repository name.
    repository_name: []const u8,

    /// The repository provider.
    repository_provider: RepositoryProvider,

    /// The sync type. The only supported value is `TEMPLATE_SYNC`.
    sync_type: SyncType,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .repository_name = "repositoryName",
        .repository_provider = "repositoryProvider",
        .sync_type = "syncType",
    };
};

pub const ListRepositorySyncDefinitionsOutput = struct {
    /// A token that indicates the location of the next repository sync definition
    /// in the array of repository sync definitions, after the current requested
    /// list of repository sync definitions.
    next_token: ?[]const u8 = null,

    /// An array of repository sync definitions.
    sync_definitions: ?[]const RepositorySyncDefinition = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .sync_definitions = "syncDefinitions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRepositorySyncDefinitionsInput, options: CallOptions) !ListRepositorySyncDefinitionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListRepositorySyncDefinitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRepositorySyncDefinitionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListRepositorySyncDefinitionsOutput, body, allocator);
}
