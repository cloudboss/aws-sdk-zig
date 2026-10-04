const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetDepotUrlInput = struct {
    /// The unique ID of the Amazon EVS environment to get the depot URL for.
    environment_id: []const u8,

    /// Revokes the current authentication token and returns a new depot URL with a
    /// new token. Previously issued depot URLs will stop working within 5 minutes
    /// of rotation.
    rotate: ?bool = null,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .rotate = "rotate",
    };
};

pub const GetDepotUrlOutput = struct {
    /// The URL for accessing the Amazon EVS Custom Addon depot. This URL includes
    /// the authentication token as a path component.
    depot_url: []const u8,

    /// The authentication token for depot access. This token is included in the
    /// depot URL and is used to authenticate requests.
    token: []const u8,

    pub const json_field_names = .{
        .depot_url = "depotUrl",
        .token = "token",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDepotUrlInput, options: CallOptions) !GetDepotUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "evs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDepotUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evs", "evs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonElasticVMwareService.GetDepotUrl");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDepotUrlOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDepotUrlOutput, body, allocator);
}
