const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AudienceQualityMetrics = @import("audience_quality_metrics.zig").AudienceQualityMetrics;
const AudienceGenerationJobDataSource = @import("audience_generation_job_data_source.zig").AudienceGenerationJobDataSource;
const AudienceGenerationJobStatus = @import("audience_generation_job_status.zig").AudienceGenerationJobStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;

pub const GetAudienceGenerationJobInput = struct {
    /// The Amazon Resource Name (ARN) of the audience generation job that you are
    /// interested in.
    audience_generation_job_arn: []const u8,

    pub const json_field_names = .{
        .audience_generation_job_arn = "audienceGenerationJobArn",
    };
};

pub const GetAudienceGenerationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the audience generation job.
    audience_generation_job_arn: []const u8,

    /// The identifier of the collaboration that this audience generation job is
    /// associated with.
    collaboration_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the configured audience model used for
    /// this audience generation job.
    configured_audience_model_arn: []const u8,

    /// The time at which the audience generation job was created.
    create_time: i64,

    /// The description of the audience generation job.
    description: ?[]const u8 = null,

    /// Configure whether the seed users are included in the output audience. By
    /// default, Clean Rooms ML removes seed users from the output audience. If you
    /// specify `TRUE`, the seed users will appear first in the output. Clean Rooms
    /// ML does not explicitly reveal whether a user was in the seed, but the
    /// recipient of the audience will know that the first `minimumSeedSize` count
    /// of users are from the seed.
    include_seed_in_output: ?bool = null,

    /// The relevance scores for different audience sizes and the recall score of
    /// the generated audience.
    metrics: ?AudienceQualityMetrics = null,

    /// The name of the audience generation job.
    name: []const u8,

    /// The unique identifier of the protected query for this audience generation
    /// job.
    protected_query_identifier: ?[]const u8 = null,

    /// The seed audience that was used for this audience generation job. This field
    /// will be null if the account calling the API is the account that started this
    /// audience generation job.
    seed_audience: ?AudienceGenerationJobDataSource = null,

    /// The AWS account that started this audience generation job.
    started_by: ?[]const u8 = null,

    /// The status of the audience generation job.
    status: AudienceGenerationJobStatus,

    /// Details about the status of the audience generation job.
    status_details: ?StatusDetails = null,

    /// The tags that are associated to this audience generation job.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The most recent time at which the audience generation job was updated.
    update_time: i64,

    pub const json_field_names = .{
        .audience_generation_job_arn = "audienceGenerationJobArn",
        .collaboration_id = "collaborationId",
        .configured_audience_model_arn = "configuredAudienceModelArn",
        .create_time = "createTime",
        .description = "description",
        .include_seed_in_output = "includeSeedInOutput",
        .metrics = "metrics",
        .name = "name",
        .protected_query_identifier = "protectedQueryIdentifier",
        .seed_audience = "seedAudience",
        .started_by = "startedBy",
        .status = "status",
        .status_details = "statusDetails",
        .tags = "tags",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAudienceGenerationJobInput, options: CallOptions) !GetAudienceGenerationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cleanroomsml");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAudienceGenerationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanroomsml", "CleanRoomsML", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/audience-generation-job/");
    try path_buf.appendSlice(allocator, input.audience_generation_job_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAudienceGenerationJobOutput {
    var result: GetAudienceGenerationJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAudienceGenerationJobOutput, body, allocator);
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
