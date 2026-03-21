const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AudienceSizeConfig = @import("audience_size_config.zig").AudienceSizeConfig;
const TagOnCreatePolicy = @import("tag_on_create_policy.zig").TagOnCreatePolicy;
const ConfiguredAudienceModelOutputConfig = @import("configured_audience_model_output_config.zig").ConfiguredAudienceModelOutputConfig;
const SharedAudienceMetrics = @import("shared_audience_metrics.zig").SharedAudienceMetrics;
const ConfiguredAudienceModelStatus = @import("configured_audience_model_status.zig").ConfiguredAudienceModelStatus;

pub const GetConfiguredAudienceModelInput = struct {
    /// The Amazon Resource Name (ARN) of the configured audience model that you are
    /// interested in.
    configured_audience_model_arn: []const u8,

    pub const json_field_names = .{
        .configured_audience_model_arn = "configuredAudienceModelArn",
    };
};

pub const GetConfiguredAudienceModelOutput = struct {
    /// The Amazon Resource Name (ARN) of the audience model used for this
    /// configured audience model.
    audience_model_arn: []const u8,

    /// The list of output sizes of audiences that can be created using this
    /// configured audience model. A request to StartAudienceGenerationJob that uses
    /// this configured audience model must have an `audienceSize` selected from
    /// this list. You can use the `ABSOLUTE` AudienceSize to configure out audience
    /// sizes using the count of identifiers in the output. You can use the
    /// `Percentage` AudienceSize to configure sizes in the range 1-100 percent.
    audience_size_config: ?AudienceSizeConfig = null,

    /// Provides the `childResourceTagOnCreatePolicy` that was used for this
    /// configured audience model.
    child_resource_tag_on_create_policy: ?TagOnCreatePolicy = null,

    /// The Amazon Resource Name (ARN) of the configured audience model.
    configured_audience_model_arn: []const u8,

    /// The time at which the configured audience model was created.
    create_time: i64,

    /// The description of the configured audience model.
    description: ?[]const u8 = null,

    /// The minimum number of users from the seed audience that must match with
    /// users in the training data of the audience model.
    min_matching_seed_size: ?i32 = null,

    /// The name of the configured audience model.
    name: []const u8,

    /// The output configuration of the configured audience model
    output_config: ?ConfiguredAudienceModelOutputConfig = null,

    /// Whether audience metrics are shared.
    shared_audience_metrics: ?[]const SharedAudienceMetrics = null,

    /// The status of the configured audience model.
    status: ConfiguredAudienceModelStatus,

    /// The tags that are associated to this configured audience model.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The most recent time at which the configured audience model was updated.
    update_time: i64,

    pub const json_field_names = .{
        .audience_model_arn = "audienceModelArn",
        .audience_size_config = "audienceSizeConfig",
        .child_resource_tag_on_create_policy = "childResourceTagOnCreatePolicy",
        .configured_audience_model_arn = "configuredAudienceModelArn",
        .create_time = "createTime",
        .description = "description",
        .min_matching_seed_size = "minMatchingSeedSize",
        .name = "name",
        .output_config = "outputConfig",
        .shared_audience_metrics = "sharedAudienceMetrics",
        .status = "status",
        .tags = "tags",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfiguredAudienceModelInput, options: CallOptions) !GetConfiguredAudienceModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cleanrooms-ml");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfiguredAudienceModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/configured-audience-model/");
    try path_buf.appendSlice(allocator, input.configured_audience_model_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfiguredAudienceModelOutput {
    var result: GetConfiguredAudienceModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetConfiguredAudienceModelOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
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
