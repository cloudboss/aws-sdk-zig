const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ActivationState = @import("activation_state.zig").ActivationState;
const ComputeQuotaConfig = @import("compute_quota_config.zig").ComputeQuotaConfig;
const ComputeQuotaTarget = @import("compute_quota_target.zig").ComputeQuotaTarget;
const Tag = @import("tag.zig").Tag;

pub const CreateComputeQuotaInput = struct {
    /// The state of the compute allocation being described. Use to enable or
    /// disable compute allocation.
    ///
    /// Default is `Enabled`.
    activation_state: ?ActivationState = null,

    /// ARN of the cluster.
    cluster_arn: []const u8,

    /// Configuration of the compute allocation definition. This includes the
    /// resource sharing option, and the setting to preempt low priority tasks.
    compute_quota_config: ComputeQuotaConfig,

    /// The target entity to allocate compute resources to.
    compute_quota_target: ComputeQuotaTarget,

    /// Description of the compute allocation definition.
    description: ?[]const u8 = null,

    /// Name to the compute allocation definition.
    name: []const u8,

    /// Tags of the compute allocation definition.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .activation_state = "ActivationState",
        .cluster_arn = "ClusterArn",
        .compute_quota_config = "ComputeQuotaConfig",
        .compute_quota_target = "ComputeQuotaTarget",
        .description = "Description",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateComputeQuotaOutput = struct {
    /// ARN of the compute allocation definition.
    compute_quota_arn: []const u8,

    /// ID of the compute allocation definition.
    compute_quota_id: []const u8,

    pub const json_field_names = .{
        .compute_quota_arn = "ComputeQuotaArn",
        .compute_quota_id = "ComputeQuotaId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateComputeQuotaInput, options: CallOptions) !CreateComputeQuotaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateComputeQuotaInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateComputeQuota");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateComputeQuotaOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateComputeQuotaOutput, body, allocator);
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
