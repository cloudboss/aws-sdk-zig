const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const UserContext = @import("user_context.zig").UserContext;
const ModelCardProcessingStatus = @import("model_card_processing_status.zig").ModelCardProcessingStatus;
const ModelCardStatus = @import("model_card_status.zig").ModelCardStatus;
const ModelCardSecurityConfig = @import("model_card_security_config.zig").ModelCardSecurityConfig;

pub const DescribeModelCardInput = struct {
    /// The name or Amazon Resource Name (ARN) of the model card to describe.
    model_card_name: []const u8,

    /// The version of the model card to describe. If a version is not provided,
    /// then the latest version of the model card is described.
    model_card_version: ?i32 = null,

    pub const json_field_names = .{
        .model_card_name = "ModelCardName",
        .model_card_version = "ModelCardVersion",
    };
};

pub const DescribeModelCardOutput = struct {
    /// The content of the model card.
    content: []const u8,

    created_by: ?UserContext = null,

    /// The date and time the model card was created.
    creation_time: i64,

    last_modified_by: ?UserContext = null,

    /// The date and time the model card was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the model card.
    model_card_arn: []const u8,

    /// The name of the model card.
    model_card_name: []const u8,

    /// The processing status of model card deletion. The
    /// `ModelCardProcessingStatus` updates throughout the different deletion steps.
    ///
    /// * `DeletePending`: Model card deletion request received.
    /// * `DeleteInProgress`: Model card deletion is in progress.
    /// * `ContentDeleted`: Deleted model card content.
    /// * `ExportJobsDeleted`: Deleted all export jobs associated with the model
    ///   card.
    /// * `DeleteCompleted`: Successfully deleted the model card.
    /// * `DeleteFailed`: The model card failed to delete.
    model_card_processing_status: ?ModelCardProcessingStatus = null,

    /// The approval status of the model card within your organization. Different
    /// organizations might have different criteria for model card review and
    /// approval.
    ///
    /// * `Draft`: The model card is a work in progress.
    /// * `PendingReview`: The model card is pending review.
    /// * `Approved`: The model card is approved.
    /// * `Archived`: The model card is archived. No more updates should be made to
    ///   the model card, but it can still be exported.
    model_card_status: ModelCardStatus,

    /// The version of the model card.
    model_card_version: i32,

    /// The security configuration used to protect model card content.
    security_config: ?ModelCardSecurityConfig = null,

    pub const json_field_names = .{
        .content = "Content",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .model_card_arn = "ModelCardArn",
        .model_card_name = "ModelCardName",
        .model_card_processing_status = "ModelCardProcessingStatus",
        .model_card_status = "ModelCardStatus",
        .model_card_version = "ModelCardVersion",
        .security_config = "SecurityConfig",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeModelCardInput, options: Options) !DescribeModelCardOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeModelCardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeModelCard");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeModelCardOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeModelCardOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
