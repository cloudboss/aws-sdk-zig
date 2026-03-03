const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const WebAppEndpointDetails = @import("web_app_endpoint_details.zig").WebAppEndpointDetails;
const WebAppIdentityProviderDetails = @import("web_app_identity_provider_details.zig").WebAppIdentityProviderDetails;
const Tag = @import("tag.zig").Tag;
const WebAppEndpointPolicy = @import("web_app_endpoint_policy.zig").WebAppEndpointPolicy;
const WebAppUnits = @import("web_app_units.zig").WebAppUnits;

pub const CreateWebAppInput = struct {
    /// The `AccessEndpoint` is the URL that you provide to your users for them to
    /// interact with the Transfer Family web app. You can specify a custom URL or
    /// use the default value.
    ///
    /// Before you enter a custom URL for this parameter, follow the steps described
    /// in [Update your access endpoint with a custom
    /// URL](https://docs.aws.amazon.com/transfer/latest/userguide/webapp-customize.html).
    access_endpoint: ?[]const u8 = null,

    /// The endpoint configuration for the web app. You can specify whether the web
    /// app endpoint is publicly accessible or hosted within a VPC.
    endpoint_details: ?WebAppEndpointDetails = null,

    /// You can provide a structure that contains the details for the identity
    /// provider to use with your web app.
    ///
    /// For more details about this parameter, see [Configure your identity provider
    /// for Transfer Family web
    /// apps](https://docs.aws.amazon.com/transfer/latest/userguide/webapp-identity-center.html).
    identity_provider_details: WebAppIdentityProviderDetails,

    /// Key-value pairs that can be used to group and search for web apps.
    tags: ?[]const Tag = null,

    /// Setting for the type of endpoint policy for the web app. The default value
    /// is `STANDARD`.
    ///
    /// If you are creating the web app in an Amazon Web Services GovCloud (US)
    /// Region, you can set this parameter to `FIPS`.
    web_app_endpoint_policy: ?WebAppEndpointPolicy = null,

    /// A union that contains the value for number of concurrent connections or the
    /// user sessions on your web app.
    web_app_units: ?WebAppUnits = null,

    pub const json_field_names = .{
        .access_endpoint = "AccessEndpoint",
        .endpoint_details = "EndpointDetails",
        .identity_provider_details = "IdentityProviderDetails",
        .tags = "Tags",
        .web_app_endpoint_policy = "WebAppEndpointPolicy",
        .web_app_units = "WebAppUnits",
    };
};

pub const CreateWebAppOutput = struct {
    /// Returns a unique identifier for the web app.
    web_app_id: []const u8,

    pub const json_field_names = .{
        .web_app_id = "WebAppId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWebAppInput, options: Options) !CreateWebAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "transfer");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWebAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.CreateWebApp");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWebAppOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateWebAppOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
