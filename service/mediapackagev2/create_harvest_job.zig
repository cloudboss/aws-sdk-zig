const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Destination = @import("destination.zig").Destination;
const HarvestedManifests = @import("harvested_manifests.zig").HarvestedManifests;
const HarvesterScheduleConfiguration = @import("harvester_schedule_configuration.zig").HarvesterScheduleConfiguration;
const HarvestJobStatus = @import("harvest_job_status.zig").HarvestJobStatus;

pub const CreateHarvestJobInput = struct {
    /// The name of the channel group containing the channel from which to harvest
    /// content.
    channel_group_name: []const u8,

    /// The name of the channel from which to harvest content.
    channel_name: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// An optional description for the harvest job.
    description: ?[]const u8 = null,

    /// The S3 destination where the harvested content will be placed.
    destination: Destination,

    /// A list of manifests to be harvested.
    harvested_manifests: HarvestedManifests,

    /// A name for the harvest job. This name must be unique within the channel.
    harvest_job_name: ?[]const u8 = null,

    /// The name of the origin endpoint from which to harvest content.
    origin_endpoint_name: []const u8,

    /// The configuration for when the harvest job should run, including start and
    /// end times.
    schedule_configuration: HarvesterScheduleConfiguration,

    /// A collection of tags associated with the harvest job.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .client_token = "ClientToken",
        .description = "Description",
        .destination = "Destination",
        .harvested_manifests = "HarvestedManifests",
        .harvest_job_name = "HarvestJobName",
        .origin_endpoint_name = "OriginEndpointName",
        .schedule_configuration = "ScheduleConfiguration",
        .tags = "Tags",
    };
};

pub const CreateHarvestJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the created harvest job.
    arn: []const u8,

    /// The name of the channel group containing the channel from which content is
    /// being harvested.
    channel_group_name: []const u8,

    /// The name of the channel from which content is being harvested.
    channel_name: []const u8,

    /// The date and time the harvest job was created.
    created_at: i64,

    /// The description of the harvest job, if provided.
    description: ?[]const u8 = null,

    /// The S3 destination where the harvested content will be placed.
    destination: ?Destination = null,

    /// An error message if the harvest job creation failed.
    error_message: ?[]const u8 = null,

    /// The current version of the harvest job. Used for concurrency control.
    e_tag: ?[]const u8 = null,

    /// A list of manifests that will be harvested.
    harvested_manifests: ?HarvestedManifests = null,

    /// The name of the created harvest job.
    harvest_job_name: []const u8,

    /// The date and time the harvest job was last modified.
    modified_at: i64,

    /// The name of the origin endpoint from which content is being harvested.
    origin_endpoint_name: []const u8,

    /// The configuration for when the harvest job will run, including start and end
    /// times.
    schedule_configuration: ?HarvesterScheduleConfiguration = null,

    /// The current status of the harvest job (e.g., CREATED, IN_PROGRESS, ABORTED,
    /// COMPLETED, FAILED).
    status: HarvestJobStatus,

    /// A collection of tags associated with the harvest job.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .created_at = "CreatedAt",
        .description = "Description",
        .destination = "Destination",
        .error_message = "ErrorMessage",
        .e_tag = "ETag",
        .harvested_manifests = "HarvestedManifests",
        .harvest_job_name = "HarvestJobName",
        .modified_at = "ModifiedAt",
        .origin_endpoint_name = "OriginEndpointName",
        .schedule_configuration = "ScheduleConfiguration",
        .status = "Status",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHarvestJobInput, options: Options) !CreateHarvestJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediapackagev2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateHarvestJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/channelGroup/");
    try path_buf.appendSlice(alloc, input.channel_group_name);
    try path_buf.appendSlice(alloc, "/channel/");
    try path_buf.appendSlice(alloc, input.channel_name);
    try path_buf.appendSlice(alloc, "/originEndpoint/");
    try path_buf.appendSlice(alloc, input.origin_endpoint_name);
    try path_buf.appendSlice(alloc, "/harvestJob");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Destination\":");
    try aws.json.writeValue(@TypeOf(input.destination), input.destination, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"HarvestedManifests\":");
    try aws.json.writeValue(@TypeOf(input.harvested_manifests), input.harvested_manifests, alloc, &body_buf);
    has_prev = true;
    if (input.harvest_job_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"HarvestJobName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ScheduleConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.schedule_configuration), input.schedule_configuration, alloc, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.client_token) |v| {
        try request.headers.put(alloc, "x-amzn-client-token", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateHarvestJobOutput {
    var result: CreateHarvestJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateHarvestJobOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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
