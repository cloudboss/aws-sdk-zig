const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Blueprint = @import("blueprint.zig").Blueprint;
const DataAutomationConfiguration = @import("data_automation_configuration.zig").DataAutomationConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const SyncInputConfiguration = @import("sync_input_configuration.zig").SyncInputConfiguration;
const OutputConfiguration = @import("output_configuration.zig").OutputConfiguration;
const OutputSegment = @import("output_segment.zig").OutputSegment;
const SemanticModality = @import("semantic_modality.zig").SemanticModality;

pub const InvokeDataAutomationInput = struct {
    /// Blueprint list.
    blueprints: ?[]const Blueprint = null,

    /// Data automation configuration.
    data_automation_configuration: ?DataAutomationConfiguration = null,

    /// Data automation profile ARN
    data_automation_profile_arn: []const u8,

    /// Encryption configuration.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// Input configuration.
    input_configuration: SyncInputConfiguration,

    /// Output configuration.
    output_configuration: ?OutputConfiguration = null,

    pub const json_field_names = .{
        .blueprints = "blueprints",
        .data_automation_configuration = "dataAutomationConfiguration",
        .data_automation_profile_arn = "dataAutomationProfileArn",
        .encryption_configuration = "encryptionConfiguration",
        .input_configuration = "inputConfiguration",
        .output_configuration = "outputConfiguration",
    };
};

pub const InvokeDataAutomationOutput = struct {
    /// Output configuration
    output_configuration: ?OutputConfiguration = null,

    /// List of outputs for each logical sub-doc
    output_segments: []const OutputSegment = &.{},

    /// Detected semantic modality
    semantic_modality: SemanticModality,

    pub const json_field_names = .{
        .output_configuration = "outputConfiguration",
        .output_segments = "outputSegments",
        .semantic_modality = "semanticModality",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeDataAutomationInput, options: Options) !InvokeDataAutomationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrockdataautomationruntime");

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

fn serializeRequest(alloc: std.mem.Allocator, input: InvokeDataAutomationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockdataautomationruntime", "Bedrock Data Automation Runtime", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonBedrockKeystoneRuntimeService.InvokeDataAutomation");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !InvokeDataAutomationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(InvokeDataAutomationOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
