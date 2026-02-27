const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReservedCapacityInstanceType = @import("reserved_capacity_instance_type.zig").ReservedCapacityInstanceType;
const ReservedCapacityType = @import("reserved_capacity_type.zig").ReservedCapacityType;
const ReservedCapacityStatus = @import("reserved_capacity_status.zig").ReservedCapacityStatus;
const UltraServerSummary = @import("ultra_server_summary.zig").UltraServerSummary;

pub const DescribeReservedCapacityInput = struct {
    /// ARN of the reserved capacity to describe.
    reserved_capacity_arn: []const u8,

    pub const json_field_names = .{
        .reserved_capacity_arn = "ReservedCapacityArn",
    };
};

pub const DescribeReservedCapacityOutput = struct {
    /// The Availability Zone where the reserved capacity is provisioned.
    availability_zone: ?[]const u8 = null,

    /// The number of instances currently available for use in this reserved
    /// capacity.
    available_instance_count: ?i32 = null,

    /// The total duration of the reserved capacity in hours.
    duration_hours: ?i64 = null,

    /// The number of minutes for the duration of the reserved capacity. For
    /// example, if a reserved capacity starts at 08:55 and ends at 11:30, the
    /// minutes field would be 35.
    duration_minutes: ?i64 = null,

    /// The timestamp when the reserved capacity expires.
    end_time: ?i64 = null,

    /// The Amazon EC2 instance type used in the reserved capacity.
    instance_type: ReservedCapacityInstanceType,

    /// The number of instances currently in use from this reserved capacity.
    in_use_instance_count: ?i32 = null,

    /// ARN of the reserved capacity.
    reserved_capacity_arn: []const u8,

    /// The type of reserved capacity.
    reserved_capacity_type: ?ReservedCapacityType = null,

    /// The timestamp when the reserved capacity becomes active.
    start_time: ?i64 = null,

    /// The current status of the reserved capacity.
    status: ?ReservedCapacityStatus = null,

    /// The total number of instances allocated to this reserved capacity.
    total_instance_count: i32,

    /// A summary of the UltraServer associated with this reserved capacity.
    ultra_server_summary: ?UltraServerSummary = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .available_instance_count = "AvailableInstanceCount",
        .duration_hours = "DurationHours",
        .duration_minutes = "DurationMinutes",
        .end_time = "EndTime",
        .instance_type = "InstanceType",
        .in_use_instance_count = "InUseInstanceCount",
        .reserved_capacity_arn = "ReservedCapacityArn",
        .reserved_capacity_type = "ReservedCapacityType",
        .start_time = "StartTime",
        .status = "Status",
        .total_instance_count = "TotalInstanceCount",
        .ultra_server_summary = "UltraServerSummary",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReservedCapacityInput, options: Options) !DescribeReservedCapacityOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeReservedCapacityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeReservedCapacity");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeReservedCapacityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeReservedCapacityOutput, body, alloc);
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
