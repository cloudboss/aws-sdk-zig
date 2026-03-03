const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const TrackingServerSize = @import("tracking_server_size.zig").TrackingServerSize;

pub const CreateMlflowTrackingServerInput = struct {
    /// The S3 URI for a general purpose bucket to use as the MLflow Tracking Server
    /// artifact store.
    artifact_store_uri: []const u8,

    /// Whether to enable or disable automatic registration of new MLflow models to
    /// the SageMaker Model Registry. To enable automatic model registration, set
    /// this value to `True`. To disable automatic model registration, set this
    /// value to `False`. If not specified, `AutomaticModelRegistration` defaults to
    /// `False`.
    automatic_model_registration: ?bool = null,

    /// The version of MLflow that the tracking server uses. To see which MLflow
    /// versions are available to use, see [How it
    /// works](https://docs.aws.amazon.com/sagemaker/latest/dg/mlflow.html#mlflow-create-tracking-server-how-it-works).
    mlflow_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for an IAM role in your account that the
    /// MLflow Tracking Server uses to access the artifact store in Amazon S3. The
    /// role should have `AmazonS3FullAccess` permissions. For more information on
    /// IAM permissions for tracking server creation, see [Set up IAM permissions
    /// for
    /// MLflow](https://docs.aws.amazon.com/sagemaker/latest/dg/mlflow-create-tracking-server-iam.html).
    role_arn: []const u8,

    /// Tags consisting of key-value pairs used to manage metadata for the tracking
    /// server.
    tags: ?[]const Tag = null,

    /// A unique string identifying the tracking server name. This string is part of
    /// the tracking server ARN.
    tracking_server_name: []const u8,

    /// The size of the tracking server you want to create. You can choose between
    /// `"Small"`, `"Medium"`, and `"Large"`. The default MLflow Tracking Server
    /// configuration size is `"Small"`. You can choose a size depending on the
    /// projected use of the tracking server such as the volume of data logged,
    /// number of users, and frequency of use.
    ///
    /// We recommend using a small tracking server for teams of up to 25 users, a
    /// medium tracking server for teams of up to 50 users, and a large tracking
    /// server for teams of up to 100 users.
    tracking_server_size: ?TrackingServerSize = null,

    /// The day and time of the week in Coordinated Universal Time (UTC) 24-hour
    /// standard time that weekly maintenance updates are scheduled. For example:
    /// TUE:03:30.
    weekly_maintenance_window_start: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_store_uri = "ArtifactStoreUri",
        .automatic_model_registration = "AutomaticModelRegistration",
        .mlflow_version = "MlflowVersion",
        .role_arn = "RoleArn",
        .tags = "Tags",
        .tracking_server_name = "TrackingServerName",
        .tracking_server_size = "TrackingServerSize",
        .weekly_maintenance_window_start = "WeeklyMaintenanceWindowStart",
    };
};

pub const CreateMlflowTrackingServerOutput = struct {
    /// The ARN of the tracking server.
    tracking_server_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .tracking_server_arn = "TrackingServerArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMlflowTrackingServerInput, options: CallOptions) !CreateMlflowTrackingServerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMlflowTrackingServerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateMlflowTrackingServer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMlflowTrackingServerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMlflowTrackingServerOutput, body, allocator);
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
