const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentAccountConnection = @import("environment_account_connection.zig").EnvironmentAccountConnection;

pub const GetEnvironmentAccountConnectionInput = struct {
    /// The ID of the environment account connection that you want to get the
    /// detailed data for.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetEnvironmentAccountConnectionOutput = struct {
    /// The detailed data of the requested environment account connection.
    environment_account_connection: ?EnvironmentAccountConnection = null,

    pub const json_field_names = .{
        .environment_account_connection = "environmentAccountConnection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnvironmentAccountConnectionInput, options: CallOptions) !GetEnvironmentAccountConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnvironmentAccountConnectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.GetEnvironmentAccountConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnvironmentAccountConnectionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetEnvironmentAccountConnectionOutput, body, allocator);
}
