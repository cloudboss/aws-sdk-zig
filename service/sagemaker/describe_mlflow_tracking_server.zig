const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const UserContext = @import("user_context.zig").UserContext;
const IsTrackingServerActive = @import("is_tracking_server_active.zig").IsTrackingServerActive;
const TrackingServerMaintenanceStatus = @import("tracking_server_maintenance_status.zig").TrackingServerMaintenanceStatus;
const TrackingServerSize = @import("tracking_server_size.zig").TrackingServerSize;
const TrackingServerStatus = @import("tracking_server_status.zig").TrackingServerStatus;

pub const DescribeMlflowTrackingServerInput = struct {
    /// The name of the MLflow Tracking Server to describe.
    tracking_server_name: []const u8,

    pub const json_field_names = .{
        .tracking_server_name = "TrackingServerName",
    };
};

pub const DescribeMlflowTrackingServerOutput = struct {
    /// The S3 URI of the general purpose bucket used as the MLflow Tracking Server
    /// artifact store.
    artifact_store_uri: ?[]const u8 = null,

    /// Whether automatic registration of new MLflow models to the SageMaker Model
    /// Registry is enabled.
    automatic_model_registration: ?bool = null,

    created_by: ?UserContext = null,

    /// The timestamp of when the described MLflow Tracking Server was created.
    creation_time: ?i64 = null,

    /// Whether the described MLflow Tracking Server is currently active.
    is_active: ?IsTrackingServerActive = null,

    last_modified_by: ?UserContext = null,

    /// The timestamp of when the described MLflow Tracking Server was last
    /// modified.
    last_modified_time: ?i64 = null,

    /// The MLflow version used for the described tracking server.
    mlflow_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for an IAM role in your account that the
    /// described MLflow Tracking Server uses to access the artifact store in Amazon
    /// S3.
    role_arn: ?[]const u8 = null,

    /// The ARN of the described tracking server.
    tracking_server_arn: ?[]const u8 = null,

    /// The current maintenance status of the described MLflow Tracking Server.
    tracking_server_maintenance_status: ?TrackingServerMaintenanceStatus = null,

    /// The name of the described tracking server.
    tracking_server_name: ?[]const u8 = null,

    /// The size of the described tracking server.
    tracking_server_size: ?TrackingServerSize = null,

    /// The current creation status of the described MLflow Tracking Server.
    tracking_server_status: ?TrackingServerStatus = null,

    /// The URL to connect to the MLflow user interface for the described tracking
    /// server.
    tracking_server_url: ?[]const u8 = null,

    /// The day and time of the week when weekly maintenance occurs on the described
    /// tracking server.
    weekly_maintenance_window_start: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_store_uri = "ArtifactStoreUri",
        .automatic_model_registration = "AutomaticModelRegistration",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .is_active = "IsActive",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .mlflow_version = "MlflowVersion",
        .role_arn = "RoleArn",
        .tracking_server_arn = "TrackingServerArn",
        .tracking_server_maintenance_status = "TrackingServerMaintenanceStatus",
        .tracking_server_name = "TrackingServerName",
        .tracking_server_size = "TrackingServerSize",
        .tracking_server_status = "TrackingServerStatus",
        .tracking_server_url = "TrackingServerUrl",
        .weekly_maintenance_window_start = "WeeklyMaintenanceWindowStart",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMlflowTrackingServerInput, options: Options) !DescribeMlflowTrackingServerOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMlflowTrackingServerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeMlflowTrackingServer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMlflowTrackingServerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMlflowTrackingServerOutput, body, allocator);
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
