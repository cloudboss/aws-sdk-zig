const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HealthCheckConfig = @import("health_check_config.zig").HealthCheckConfig;
const TargetGroupConfig = @import("target_group_config.zig").TargetGroupConfig;
const TargetGroupStatus = @import("target_group_status.zig").TargetGroupStatus;
const TargetGroupType = @import("target_group_type.zig").TargetGroupType;

pub const UpdateTargetGroupInput = struct {
    /// The health check configuration.
    health_check: HealthCheckConfig,

    /// The ID or ARN of the target group.
    target_group_identifier: []const u8,

    pub const json_field_names = .{
        .health_check = "healthCheck",
        .target_group_identifier = "targetGroupIdentifier",
    };
};

pub const UpdateTargetGroupOutput = struct {
    /// The Amazon Resource Name (ARN) of the target group.
    arn: ?[]const u8 = null,

    /// The target group configuration.
    config: ?TargetGroupConfig = null,

    /// The ID of the target group.
    id: ?[]const u8 = null,

    /// The name of the target group.
    name: ?[]const u8 = null,

    /// The status.
    status: ?TargetGroupStatus = null,

    /// The target group type.
    type: ?TargetGroupType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .config = "config",
        .id = "id",
        .name = "name",
        .status = "status",
        .type = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTargetGroupInput, options: CallOptions) !UpdateTargetGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTargetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/targetgroups/");
    try path_buf.appendSlice(allocator, input.target_group_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"healthCheck\":");
    try aws.json.writeValue(@TypeOf(input.health_check), input.health_check, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTargetGroupOutput {
    const result: UpdateTargetGroupOutput = try aws.json.parseJsonObject(
        UpdateTargetGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
