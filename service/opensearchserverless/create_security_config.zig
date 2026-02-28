const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IamFederationConfigOptions = @import("iam_federation_config_options.zig").IamFederationConfigOptions;
const CreateIamIdentityCenterConfigOptions = @import("create_iam_identity_center_config_options.zig").CreateIamIdentityCenterConfigOptions;
const SamlConfigOptions = @import("saml_config_options.zig").SamlConfigOptions;
const SecurityConfigType = @import("security_config_type.zig").SecurityConfigType;
const SecurityConfigDetail = @import("security_config_detail.zig").SecurityConfigDetail;

pub const CreateSecurityConfigInput = struct {
    /// Unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// A description of the security configuration.
    description: ?[]const u8 = null,

    /// Describes IAM federation options in the form of a key-value map. This field
    /// is required if you specify `iamFederation` for the `type` parameter.
    iam_federation_options: ?IamFederationConfigOptions = null,

    /// Describes IAM Identity Center options in the form of a key-value map. This
    /// field is required if you specify `iamidentitycenter` for the `type`
    /// parameter.
    iam_identity_center_options: ?CreateIamIdentityCenterConfigOptions = null,

    /// The name of the security configuration.
    name: []const u8,

    /// Describes SAML options in the form of a key-value map. This field is
    /// required if you specify `SAML` for the `type` parameter.
    saml_options: ?SamlConfigOptions = null,

    /// The type of security configuration.
    @"type": SecurityConfigType,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .iam_federation_options = "iamFederationOptions",
        .iam_identity_center_options = "iamIdentityCenterOptions",
        .name = "name",
        .saml_options = "samlOptions",
        .@"type" = "type",
    };
};

pub const CreateSecurityConfigOutput = struct {
    /// Details about the created security configuration.
    security_config_detail: ?SecurityConfigDetail = null,

    pub const json_field_names = .{
        .security_config_detail = "securityConfigDetail",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSecurityConfigInput, options: Options) !CreateSecurityConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "opensearchserverless");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateSecurityConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("opensearchserverless", "OpenSearchServerless", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "OpenSearchServerless.CreateSecurityConfig");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateSecurityConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSecurityConfigOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OcuLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .ocu_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
