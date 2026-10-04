const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RelationalDatabasePasswordVersion = @import("relational_database_password_version.zig").RelationalDatabasePasswordVersion;

pub const GetRelationalDatabaseMasterUserPasswordInput = struct {
    /// The password version to return.
    ///
    /// Specifying `CURRENT` or `PREVIOUS` returns the current or previous
    /// passwords respectively. Specifying `PENDING` returns the newest version of
    /// the
    /// password that will rotate to `CURRENT`. After the `PENDING` password
    /// rotates to `CURRENT`, the `PENDING` password is no longer
    /// available.
    ///
    /// Default: `CURRENT`
    password_version: ?RelationalDatabasePasswordVersion = null,

    /// The name of your database for which to get the master user password.
    relational_database_name: []const u8,

    pub const json_field_names = .{
        .password_version = "passwordVersion",
        .relational_database_name = "relationalDatabaseName",
    };
};

pub const GetRelationalDatabaseMasterUserPasswordOutput = struct {
    /// The timestamp when the specified version of the master user password was
    /// created.
    created_at: ?i64 = null,

    /// The master user password for the `password version` specified.
    master_user_password: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .master_user_password = "masterUserPassword",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRelationalDatabaseMasterUserPasswordInput, options: CallOptions) !GetRelationalDatabaseMasterUserPasswordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRelationalDatabaseMasterUserPasswordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.GetRelationalDatabaseMasterUserPassword");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRelationalDatabaseMasterUserPasswordOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRelationalDatabaseMasterUserPasswordOutput, body, allocator);
}
