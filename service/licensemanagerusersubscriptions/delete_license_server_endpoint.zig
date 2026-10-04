const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServerType = @import("server_type.zig").ServerType;
const LicenseServerEndpoint = @import("license_server_endpoint.zig").LicenseServerEndpoint;

pub const DeleteLicenseServerEndpointInput = struct {
    /// The Amazon Resource Name (ARN) that identifies the `LicenseServerEndpoint`
    /// resource to delete.
    license_server_endpoint_arn: []const u8,

    /// The type of License Server that the delete request refers to.
    server_type: ServerType,

    pub const json_field_names = .{
        .license_server_endpoint_arn = "LicenseServerEndpointArn",
        .server_type = "ServerType",
    };
};

pub const DeleteLicenseServerEndpointOutput = struct {
    /// Shows details from the `LicenseServerEndpoint` resource that was deleted.
    license_server_endpoint: ?LicenseServerEndpoint = null,

    pub const json_field_names = .{
        .license_server_endpoint = "LicenseServerEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteLicenseServerEndpointInput, options: CallOptions) !DeleteLicenseServerEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager-user-subscriptions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteLicenseServerEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager-user-subscriptions", "License Manager User Subscriptions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/license-server/DeleteLicenseServerEndpoint";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LicenseServerEndpointArn\":");
    try aws.json.writeValue(@TypeOf(input.license_server_endpoint_arn), input.license_server_endpoint_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ServerType\":");
    try aws.json.writeValue(@TypeOf(input.server_type), input.server_type, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteLicenseServerEndpointOutput {
    const result: DeleteLicenseServerEndpointOutput = try aws.json.parseJsonObject(
        DeleteLicenseServerEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
