const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CommitmentDuration = @import("commitment_duration.zig").CommitmentDuration;
const ProvisionedModelStatus = @import("provisioned_model_status.zig").ProvisionedModelStatus;

pub const GetProvisionedModelThroughputInput = struct {
    /// The Amazon Resource Name (ARN) or name of the Provisioned Throughput.
    provisioned_model_id: []const u8,

    pub const json_field_names = .{
        .provisioned_model_id = "provisionedModelId",
    };
};

pub const GetProvisionedModelThroughputOutput = struct {
    /// Commitment duration of the Provisioned Throughput.
    commitment_duration: ?CommitmentDuration = null,

    /// The timestamp for when the commitment term for the Provisioned Throughput
    /// expires.
    commitment_expiration_time: ?i64 = null,

    /// The timestamp of the creation time for this Provisioned Throughput.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the model requested to be associated to
    /// this Provisioned Throughput. This value differs from the `modelArn` if
    /// updating hasn't completed.
    desired_model_arn: []const u8,

    /// The number of model units that was requested for this Provisioned
    /// Throughput.
    desired_model_units: i32,

    /// A failure message for any issues that occurred during creation, updating, or
    /// deletion of the Provisioned Throughput.
    failure_message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the base model for which the Provisioned
    /// Throughput was created, or of the base model that the custom model for which
    /// the Provisioned Throughput was created was customized.
    foundation_model_arn: []const u8,

    /// The timestamp of the last time that this Provisioned Throughput was
    /// modified.
    last_modified_time: i64,

    /// The Amazon Resource Name (ARN) of the model associated with this Provisioned
    /// Throughput.
    model_arn: []const u8,

    /// The number of model units allocated to this Provisioned Throughput.
    model_units: i32,

    /// The Amazon Resource Name (ARN) of the Provisioned Throughput.
    provisioned_model_arn: []const u8,

    /// The name of the Provisioned Throughput.
    provisioned_model_name: []const u8,

    /// The status of the Provisioned Throughput.
    status: ProvisionedModelStatus,

    pub const json_field_names = .{
        .commitment_duration = "commitmentDuration",
        .commitment_expiration_time = "commitmentExpirationTime",
        .creation_time = "creationTime",
        .desired_model_arn = "desiredModelArn",
        .desired_model_units = "desiredModelUnits",
        .failure_message = "failureMessage",
        .foundation_model_arn = "foundationModelArn",
        .last_modified_time = "lastModifiedTime",
        .model_arn = "modelArn",
        .model_units = "modelUnits",
        .provisioned_model_arn = "provisionedModelArn",
        .provisioned_model_name = "provisionedModelName",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProvisionedModelThroughputInput, options: CallOptions) !GetProvisionedModelThroughputOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProvisionedModelThroughputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/provisioned-model-throughput/");
    try path_buf.appendSlice(allocator, input.provisioned_model_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProvisionedModelThroughputOutput {
    var result: GetProvisionedModelThroughputOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetProvisionedModelThroughputOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
