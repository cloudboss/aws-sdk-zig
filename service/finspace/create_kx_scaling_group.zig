const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const KxScalingGroupStatus = @import("kx_scaling_group_status.zig").KxScalingGroupStatus;

pub const CreateKxScalingGroupInput = struct {
    /// The identifier of the availability zones.
    availability_zone_id: []const u8,

    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: []const u8,

    /// A unique identifier for the kdb environment, where you want to create the
    /// scaling group.
    environment_id: []const u8,

    /// The memory and CPU capabilities of the scaling group host on which FinSpace
    /// Managed kdb clusters will be placed.
    ///
    /// You can add one of the following values:
    ///
    /// * `kx.sg.large` – The host type with a configuration of 16 GiB
    /// memory and 2 vCPUs.
    ///
    /// * `kx.sg.xlarge` – The host type with a configuration of 32 GiB
    /// memory and 4 vCPUs.
    ///
    /// * `kx.sg.2xlarge` – The host type with a configuration of 64 GiB
    /// memory and 8 vCPUs.
    ///
    /// * `kx.sg.4xlarge` – The host type with a configuration of 108 GiB memory and
    ///   16 vCPUs.
    ///
    /// * `kx.sg.8xlarge` – The host type with a configuration of 216 GiB memory and
    ///   32 vCPUs.
    ///
    /// * `kx.sg.16xlarge` – The host type with a configuration of 432 GiB memory
    ///   and 64 vCPUs.
    ///
    /// * `kx.sg.32xlarge` – The host type with a configuration of 864 GiB memory
    ///   and 128 vCPUs.
    ///
    /// * `kx.sg1.16xlarge` – The host type with a configuration of 1949 GiB memory
    ///   and 64 vCPUs.
    ///
    /// * `kx.sg1.24xlarge` – The host type with a configuration of 2948 GiB memory
    ///   and 96 vCPUs.
    host_type: []const u8,

    /// A unique identifier for the kdb scaling group.
    scaling_group_name: []const u8,

    /// A list of key-value pairs to label the scaling group. You can add up to 50
    /// tags to a scaling group.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .availability_zone_id = "availabilityZoneId",
        .client_token = "clientToken",
        .environment_id = "environmentId",
        .host_type = "hostType",
        .scaling_group_name = "scalingGroupName",
        .tags = "tags",
    };
};

pub const CreateKxScalingGroupOutput = struct {
    /// The identifier of the availability zones.
    availability_zone_id: ?[]const u8 = null,

    /// The timestamp at which the scaling group was created in FinSpace. The value
    /// is determined as epoch time in milliseconds. For example, the value for
    /// Monday, November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64 = null,

    /// A unique identifier for the kdb environment, where you create the scaling
    /// group.
    environment_id: ?[]const u8 = null,

    /// The memory and CPU capabilities of the scaling group host on which FinSpace
    /// Managed kdb clusters will be placed.
    host_type: ?[]const u8 = null,

    /// The last time that the scaling group was updated in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64 = null,

    /// A unique identifier for the kdb scaling group.
    scaling_group_name: ?[]const u8 = null,

    /// The status of scaling group.
    ///
    /// * CREATING – The scaling group creation is in progress.
    ///
    /// * CREATE_FAILED – The scaling group creation has failed.
    ///
    /// * ACTIVE – The scaling group is active.
    ///
    /// * UPDATING – The scaling group is in the process of being updated.
    ///
    /// * UPDATE_FAILED – The update action failed.
    ///
    /// * DELETING – The scaling group is in the process of being deleted.
    ///
    /// * DELETE_FAILED – The system failed to delete the scaling group.
    ///
    /// * DELETED – The scaling group is successfully deleted.
    status: ?KxScalingGroupStatus = null,

    pub const json_field_names = .{
        .availability_zone_id = "availabilityZoneId",
        .created_timestamp = "createdTimestamp",
        .environment_id = "environmentId",
        .host_type = "hostType",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .scaling_group_name = "scalingGroupName",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKxScalingGroupInput, options: CallOptions) !CreateKxScalingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "finspace");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKxScalingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/scalingGroups");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"availabilityZoneId\":");
    try aws.json.writeValue(@TypeOf(input.availability_zone_id), input.availability_zone_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"hostType\":");
    try aws.json.writeValue(@TypeOf(input.host_type), input.host_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scalingGroupName\":");
    try aws.json.writeValue(@TypeOf(input.scaling_group_name), input.scaling_group_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKxScalingGroupOutput {
    var result: CreateKxScalingGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateKxScalingGroupOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
