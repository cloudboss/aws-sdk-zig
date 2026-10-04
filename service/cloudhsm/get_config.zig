const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClientVersion = @import("client_version.zig").ClientVersion;

pub const GetConfigInput = struct {
    /// The ARN of the client.
    client_arn: []const u8,

    /// The client version.
    client_version: ClientVersion,

    /// A list of ARNs that identify the high-availability partition groups that are
    /// associated
    /// with the client.
    hapg_list: []const []const u8,

    pub const json_field_names = .{
        .client_arn = "ClientArn",
        .client_version = "ClientVersion",
        .hapg_list = "HapgList",
    };
};

pub const GetConfigOutput = struct {
    /// The certificate file containing the server.pem files of the HSMs.
    config_cred: ?[]const u8 = null,

    /// The chrystoki.conf configuration file.
    config_file: ?[]const u8 = null,

    /// The type of credentials.
    config_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .config_cred = "ConfigCred",
        .config_file = "ConfigFile",
        .config_type = "ConfigType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfigInput, options: CallOptions) !GetConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudhsm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsm", "CloudHSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudHsmFrontendService.GetConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetConfigOutput, body, allocator);
}
