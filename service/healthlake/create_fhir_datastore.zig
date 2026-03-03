const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FHIRVersion = @import("fhir_version.zig").FHIRVersion;
const IdentityProviderConfiguration = @import("identity_provider_configuration.zig").IdentityProviderConfiguration;
const PreloadDataConfig = @import("preload_data_config.zig").PreloadDataConfig;
const SseConfiguration = @import("sse_configuration.zig").SseConfiguration;
const Tag = @import("tag.zig").Tag;
const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;

pub const CreateFHIRDatastoreInput = struct {
    /// An optional user-provided token to ensure API idempotency.
    client_token: ?[]const u8 = null,

    /// The data store name (user-generated).
    datastore_name: ?[]const u8 = null,

    /// The FHIR release version supported by the data store. Current support is for
    /// version
    /// `R4`.
    datastore_type_version: FHIRVersion,

    /// The identity provider configuration to use for the data store.
    identity_provider_configuration: ?IdentityProviderConfiguration = null,

    /// An optional parameter to preload (import) open source Synthea FHIR data upon
    /// creation of
    /// the data store.
    preload_data_config: ?PreloadDataConfig = null,

    /// The server-side encryption key configuration for a customer-provided
    /// encryption key
    /// specified for creating a data store.
    sse_configuration: ?SseConfiguration = null,

    /// The resource tags applied to a data store when it is created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .datastore_name = "DatastoreName",
        .datastore_type_version = "DatastoreTypeVersion",
        .identity_provider_configuration = "IdentityProviderConfiguration",
        .preload_data_config = "PreloadDataConfig",
        .sse_configuration = "SseConfiguration",
        .tags = "Tags",
    };
};

pub const CreateFHIRDatastoreOutput = struct {
    /// The Amazon Resource Name (ARN) for the data store.
    datastore_arn: []const u8,

    /// The AWS endpoint created for the data store.
    datastore_endpoint: []const u8,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The data store status.
    datastore_status: DatastoreStatus,

    pub const json_field_names = .{
        .datastore_arn = "DatastoreArn",
        .datastore_endpoint = "DatastoreEndpoint",
        .datastore_id = "DatastoreId",
        .datastore_status = "DatastoreStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFHIRDatastoreInput, options: CallOptions) !CreateFHIRDatastoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "healthlake");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFHIRDatastoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("healthlake", "HealthLake", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.CreateFHIRDatastore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFHIRDatastoreOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateFHIRDatastoreOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
