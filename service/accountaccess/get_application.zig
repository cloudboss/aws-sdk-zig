const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorDetails = @import("error_details.zig").ErrorDetails;
const IdentitySourceDetails = @import("identity_source_details.zig").IdentitySourceDetails;
const Status = @import("status.zig").Status;

pub const GetApplicationInput = struct {
    /// Specifies the ARN of the application to retrieve.
    application_arn: []const u8,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
    };
};

pub const GetApplicationOutput = struct {
    /// The date and time when the application was created.
    created_at: i64,

    /// The error details if the application is in a failed state.
    @"error": ?ErrorDetails = null,

    /// The identity source details for the application, including the IAM Identity
    /// Center instance configuration.
    identity_source: ?IdentitySourceDetails = null,

    /// The current status of the application.
    status: Status,

    /// The tags associated with the application.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The tenant identifier associated with the application.
    tenant_id: ?[]const u8 = null,

    /// The date and time when the application was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .@"error" = "error",
        .identity_source = "identitySource",
        .status = "status",
        .tags = "tags",
        .tenant_id = "tenantId",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationInput, options: CallOptions) !GetApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "account-access", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("account-access", "Account Access", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationOutput {
    const result: GetApplicationOutput = try aws.json.parseJsonObject(
        GetApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
