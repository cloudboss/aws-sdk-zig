const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeEnvironment = @import("compute_environment.zig").ComputeEnvironment;
const Connection = @import("connection.zig").Connection;

pub const GetConnectionInput = struct {
    /// For connections that may be used in multiple services, specifies returning
    /// properties for the specified compute environment.
    apply_override_for_compute_environment: ?ComputeEnvironment = null,

    /// The ID of the Data Catalog in which the connection resides. If none is
    /// provided, the Amazon Web Services
    /// account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// Allows you to retrieve the connection metadata without returning the
    /// password. For
    /// instance, the Glue console uses this flag to retrieve the connection, and
    /// does not display
    /// the password. Set this parameter when the caller might not have permission
    /// to use the KMS
    /// key to decrypt the password, but it does have permission to access the rest
    /// of the connection
    /// properties.
    hide_password: ?bool = null,

    /// The name of the connection definition to retrieve.
    name: []const u8,

    pub const json_field_names = .{
        .apply_override_for_compute_environment = "ApplyOverrideForComputeEnvironment",
        .catalog_id = "CatalogId",
        .hide_password = "HidePassword",
        .name = "Name",
    };
};

pub const GetConnectionOutput = struct {
    /// The requested connection definition.
    connection: ?Connection = null,

    pub const json_field_names = .{
        .connection = "Connection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConnectionInput, options: CallOptions) !GetConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetConnectionOutput, body, allocator);
}
