const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentitySourceParametersForGet = @import("identity_source_parameters_for_get.zig").IdentitySourceParametersForGet;
const IdentitySourceType = @import("identity_source_type.zig").IdentitySourceType;
const IdentitySourceStatus = @import("identity_source_status.zig").IdentitySourceStatus;
const IdentitySourceStatusCode = @import("identity_source_status_code.zig").IdentitySourceStatusCode;

pub const GetIdentitySourceInput = struct {
    /// Amazon Resource Name (ARN) for the identity source.
    identity_source_arn: []const u8,

    pub const json_field_names = .{
        .identity_source_arn = "IdentitySourceArn",
    };
};

pub const GetIdentitySourceOutput = struct {
    /// Timestamp when the identity source was created.
    creation_time: ?i64 = null,

    /// Amazon Resource Name (ARN) for the identity source.
    identity_source_arn: ?[]const u8 = null,

    /// A ` IdentitySourceParameters` object. Contains details for the resource that
    /// provides identities to the identity source. For example, an IAM Identity
    /// Center instance.
    identity_source_parameters: ?IdentitySourceParametersForGet = null,

    /// The type of resource that provided identities to the identity source. For
    /// example, an IAM Identity Center instance.
    identity_source_type: ?IdentitySourceType = null,

    /// Status for the identity source. For example, if the identity source is
    /// `ACTIVE`.
    status: ?IdentitySourceStatus = null,

    /// Status code of the identity source.
    status_code: ?IdentitySourceStatusCode = null,

    /// Message describing the status for the identity source.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .identity_source_arn = "IdentitySourceArn",
        .identity_source_parameters = "IdentitySourceParameters",
        .identity_source_type = "IdentitySourceType",
        .status = "Status",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentitySourceInput, options: CallOptions) !GetIdentitySourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mpa", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentitySourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mpa", "MPA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/identity-sources/");
    try path_buf.appendSlice(allocator, input.identity_source_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentitySourceOutput {
    var result: GetIdentitySourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetIdentitySourceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
