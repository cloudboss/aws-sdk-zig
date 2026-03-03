const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ProviderComponentSchema = @import("provider_component_schema.zig").ProviderComponentSchema;
const ProviderEndpointConfiguration = @import("provider_endpoint_configuration.zig").ProviderEndpointConfiguration;
const ProviderIdNameSpaceConfiguration = @import("provider_id_name_space_configuration.zig").ProviderIdNameSpaceConfiguration;
const ProviderIntermediateDataAccessConfiguration = @import("provider_intermediate_data_access_configuration.zig").ProviderIntermediateDataAccessConfiguration;
const ServiceType = @import("service_type.zig").ServiceType;

pub const GetProviderServiceInput = struct {
    /// The name of the provider. This name is typically the company name.
    provider_name: []const u8,

    /// The ARN (Amazon Resource Name) of the product that the provider service
    /// provides.
    provider_service_name: []const u8,

    pub const json_field_names = .{
        .provider_name = "providerName",
        .provider_service_name = "providerServiceName",
    };
};

pub const GetProviderServiceOutput = struct {
    /// Specifies whether output data from the provider is anonymized. A value of
    /// `TRUE` means the output will be anonymized and you can't relate the data
    /// that comes back from the provider to the identifying input. A value of
    /// `FALSE` means the output won't be anonymized and you can relate the data
    /// that comes back from the provider to your source data.
    anonymized_output: bool,

    /// Input schema for the provider service.
    provider_component_schema: ?ProviderComponentSchema = null,

    /// The definition of the provider configuration.
    provider_configuration_definition: ?[]const u8 = null,

    /// The required configuration fields to use with the provider service.
    provider_endpoint_configuration: ?ProviderEndpointConfiguration = null,

    /// The definition of the provider entity output.
    provider_entity_output_definition: []const u8,

    /// The provider configuration required for different ID namespace types.
    provider_id_name_space_configuration: ?ProviderIdNameSpaceConfiguration = null,

    /// The Amazon Web Services accounts and the S3 permissions that are required by
    /// some providers to create an S3 bucket for intermediate data storage.
    provider_intermediate_data_access_configuration: ?ProviderIntermediateDataAccessConfiguration = null,

    /// Provider service job configurations.
    provider_job_configuration: ?[]const u8 = null,

    /// The name of the provider. This name is typically the company name.
    provider_name: []const u8,

    /// The ARN (Amazon Resource Name) that Entity Resolution generated for the
    /// provider service.
    provider_service_arn: []const u8,

    /// The display name of the provider service.
    provider_service_display_name: []const u8,

    /// The name of the product that the provider service provides.
    provider_service_name: []const u8,

    /// The type of provider service.
    provider_service_type: ServiceType,

    pub const json_field_names = .{
        .anonymized_output = "anonymizedOutput",
        .provider_component_schema = "providerComponentSchema",
        .provider_configuration_definition = "providerConfigurationDefinition",
        .provider_endpoint_configuration = "providerEndpointConfiguration",
        .provider_entity_output_definition = "providerEntityOutputDefinition",
        .provider_id_name_space_configuration = "providerIdNameSpaceConfiguration",
        .provider_intermediate_data_access_configuration = "providerIntermediateDataAccessConfiguration",
        .provider_job_configuration = "providerJobConfiguration",
        .provider_name = "providerName",
        .provider_service_arn = "providerServiceArn",
        .provider_service_display_name = "providerServiceDisplayName",
        .provider_service_name = "providerServiceName",
        .provider_service_type = "providerServiceType",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProviderServiceInput, options: Options) !GetProviderServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "entityresolution");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProviderServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/providerservices/");
    try path_buf.appendSlice(allocator, input.provider_name);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.provider_service_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProviderServiceOutput {
    var result: GetProviderServiceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetProviderServiceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "ExceedsLimitException")) {
        return .{ .arena = arena, .kind = .{ .exceeds_limit_exception = .{
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
