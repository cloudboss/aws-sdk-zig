const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AccountDefaultStatus = @import("account_default_status.zig").AccountDefaultStatus;
const ModelRegistrationMode = @import("model_registration_mode.zig").ModelRegistrationMode;

pub const UpdateMlflowAppInput = struct {
    /// Indicates whether this this MLflow App is the default for the account.
    account_default_status: ?AccountDefaultStatus = null,

    /// The ARN of the MLflow App to update.
    arn: []const u8,

    /// The new S3 URI for the general purpose bucket to use as the artifact store
    /// for the MLflow App.
    artifact_store_uri: ?[]const u8 = null,

    /// List of SageMaker Domain IDs for which this MLflow App is the default.
    default_domain_id_list: ?[]const []const u8 = null,

    /// Whether to enable or disable automatic registration of new MLflow models to
    /// the SageMaker Model Registry. To enable automatic model registration, set
    /// this value to `AutoModelRegistrationEnabled`. To disable automatic model
    /// registration, set this value to `AutoModelRegistrationDisabled`. If not
    /// specified, `AutomaticModelRegistration` defaults to
    /// `AutoModelRegistrationEnabled`
    model_registration_mode: ?ModelRegistrationMode = null,

    /// The name of the MLflow App to update.
    name: ?[]const u8 = null,

    /// The new weekly maintenance window start day and time to update. The
    /// maintenance window day and time should be in Coordinated Universal Time
    /// (UTC) 24-hour standard time. For example: TUE:03:30.
    weekly_maintenance_window_start: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_default_status = "AccountDefaultStatus",
        .arn = "Arn",
        .artifact_store_uri = "ArtifactStoreUri",
        .default_domain_id_list = "DefaultDomainIdList",
        .model_registration_mode = "ModelRegistrationMode",
        .name = "Name",
        .weekly_maintenance_window_start = "WeeklyMaintenanceWindowStart",
    };
};

pub const UpdateMlflowAppOutput = struct {
    /// The ARN of the updated MLflow App.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMlflowAppInput, options: CallOptions) !UpdateMlflowAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMlflowAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateMlflowApp");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMlflowAppOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateMlflowAppOutput, body, allocator);
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
