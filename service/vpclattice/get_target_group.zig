const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TargetGroupConfig = @import("target_group_config.zig").TargetGroupConfig;
const TargetGroupStatus = @import("target_group_status.zig").TargetGroupStatus;
const TargetGroupType = @import("target_group_type.zig").TargetGroupType;

pub const GetTargetGroupInput = struct {
    /// The ID or ARN of the target group.
    target_group_identifier: []const u8,

    pub const json_field_names = .{
        .target_group_identifier = "targetGroupIdentifier",
    };
};

pub const GetTargetGroupOutput = struct {
    /// The Amazon Resource Name (ARN) of the target group.
    arn: ?[]const u8 = null,

    /// The target group configuration.
    config: ?TargetGroupConfig = null,

    /// The date and time that the target group was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The failure code.
    failure_code: ?[]const u8 = null,

    /// The failure message.
    failure_message: ?[]const u8 = null,

    /// The ID of the target group.
    id: ?[]const u8 = null,

    /// The date and time that the target group was last updated, in ISO-8601
    /// format.
    last_updated_at: ?i64 = null,

    /// The name of the target group.
    name: ?[]const u8 = null,

    /// The Amazon Resource Names (ARNs) of the service.
    service_arns: ?[]const []const u8 = null,

    /// The status.
    status: ?TargetGroupStatus = null,

    /// The target group type.
    @"type": ?TargetGroupType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .config = "config",
        .created_at = "createdAt",
        .failure_code = "failureCode",
        .failure_message = "failureMessage",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .service_arns = "serviceArns",
        .status = "status",
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTargetGroupInput, options: CallOptions) !GetTargetGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTargetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/targetgroups/");
    try path_buf.appendSlice(allocator, input.target_group_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTargetGroupOutput {
    var result: GetTargetGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTargetGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
