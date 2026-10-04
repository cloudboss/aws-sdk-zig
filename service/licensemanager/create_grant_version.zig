const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AllowedOperation = @import("allowed_operation.zig").AllowedOperation;
const Options = @import("options.zig").Options;
const GrantStatus = @import("grant_status.zig").GrantStatus;

pub const CreateGrantVersionInput = struct {
    /// Allowed operations for the grant.
    allowed_operations: ?[]const AllowedOperation = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    client_token: []const u8,

    /// Amazon Resource Name (ARN) of the grant.
    grant_arn: []const u8,

    /// Grant name.
    grant_name: ?[]const u8 = null,

    /// The options specified for the grant.
    options: ?Options = null,

    /// Current version of the grant.
    source_version: ?[]const u8 = null,

    /// Grant status.
    status: ?GrantStatus = null,

    /// Grant status reason.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_operations = "AllowedOperations",
        .client_token = "ClientToken",
        .grant_arn = "GrantArn",
        .grant_name = "GrantName",
        .options = "Options",
        .source_version = "SourceVersion",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};

pub const CreateGrantVersionOutput = struct {
    /// Grant ARN.
    grant_arn: ?[]const u8 = null,

    /// Grant status.
    status: ?GrantStatus = null,

    /// New version of the grant.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .grant_arn = "GrantArn",
        .status = "Status",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGrantVersionInput, options: CallOptions) !CreateGrantVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGrantVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager", "License Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.CreateGrantVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGrantVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateGrantVersionOutput, body, allocator);
}
