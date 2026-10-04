const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentAccountConnectionRequesterAccountType = @import("environment_account_connection_requester_account_type.zig").EnvironmentAccountConnectionRequesterAccountType;
const EnvironmentAccountConnectionStatus = @import("environment_account_connection_status.zig").EnvironmentAccountConnectionStatus;
const EnvironmentAccountConnectionSummary = @import("environment_account_connection_summary.zig").EnvironmentAccountConnectionSummary;

pub const ListEnvironmentAccountConnectionsInput = struct {
    /// The environment name that's associated with each listed environment account
    /// connection.
    environment_name: ?[]const u8 = null,

    /// The maximum number of environment account connections to list.
    max_results: ?i32 = null,

    /// A token that indicates the location of the next environment account
    /// connection in the array of environment account connections, after the list
    /// of
    /// environment account connections that was previously requested.
    next_token: ?[]const u8 = null,

    /// The type of account making the `ListEnvironmentAccountConnections` request.
    requested_by: EnvironmentAccountConnectionRequesterAccountType,

    /// The status details for each listed environment account connection.
    statuses: ?[]const EnvironmentAccountConnectionStatus = null,

    pub const json_field_names = .{
        .environment_name = "environmentName",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .requested_by = "requestedBy",
        .statuses = "statuses",
    };
};

pub const ListEnvironmentAccountConnectionsOutput = struct {
    /// An array of environment account connections with details that's returned by
    /// Proton.
    environment_account_connections: ?[]const EnvironmentAccountConnectionSummary = null,

    /// A token that indicates the location of the next environment account
    /// connection in the array of environment account connections, after the
    /// current
    /// requested list of environment account connections.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_account_connections = "environmentAccountConnections",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnvironmentAccountConnectionsInput, options: CallOptions) !ListEnvironmentAccountConnectionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnvironmentAccountConnectionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListEnvironmentAccountConnections");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnvironmentAccountConnectionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEnvironmentAccountConnectionsOutput, body, allocator);
}
