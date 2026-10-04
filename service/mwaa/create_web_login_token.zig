const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateWebLoginTokenInput = struct {
    /// The name of the Amazon MWAA environment. For example, `MyMWAAEnvironment`.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const CreateWebLoginTokenOutput = struct {
    /// The user name of the Apache Airflow identity creating the web login token.
    airflow_identity: ?[]const u8 = null,

    /// The name of the IAM identity creating the web login token. This might be an
    /// IAM user, or an assumed or federated identity. For example,
    /// `assumed-role/Admin/your-name`.
    iam_identity: ?[]const u8 = null,

    /// The Airflow web server hostname for the environment.
    web_server_hostname: ?[]const u8 = null,

    /// An Airflow web server login token.
    web_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .airflow_identity = "AirflowIdentity",
        .iam_identity = "IamIdentity",
        .web_server_hostname = "WebServerHostname",
        .web_token = "WebToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWebLoginTokenInput, options: CallOptions) !CreateWebLoginTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "airflow", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWebLoginTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("airflow", "MWAA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/webtoken/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWebLoginTokenOutput {
    var result: CreateWebLoginTokenOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateWebLoginTokenOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
