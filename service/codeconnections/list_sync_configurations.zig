const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SyncConfigurationType = @import("sync_configuration_type.zig").SyncConfigurationType;
const SyncConfiguration = @import("sync_configuration.zig").SyncConfiguration;

pub const ListSyncConfigurationsInput = struct {
    /// A non-zero, non-negative integer used to limit the number of returned
    /// results.
    max_results: ?i32 = null,

    /// An enumeration token that allows the operation to batch the results of the
    /// operation.
    next_token: ?[]const u8 = null,

    /// The ID of the repository link for the requested list of sync configurations.
    repository_link_id: []const u8,

    /// The sync type for the requested list of sync configurations.
    sync_type: SyncConfigurationType,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .repository_link_id = "RepositoryLinkId",
        .sync_type = "SyncType",
    };
};

pub const ListSyncConfigurationsOutput = struct {
    /// An enumeration token that allows the operation to batch the next results of
    /// the operation.
    next_token: ?[]const u8 = null,

    /// The list of repository sync definitions returned by the request.
    sync_configurations: ?[]const SyncConfiguration = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .sync_configurations = "SyncConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSyncConfigurationsInput, options: CallOptions) !ListSyncConfigurationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSyncConfigurationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeConnections_20231201.ListSyncConfigurations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSyncConfigurationsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListSyncConfigurationsOutput, body, allocator);
}
