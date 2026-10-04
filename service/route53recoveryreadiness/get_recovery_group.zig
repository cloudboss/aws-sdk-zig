const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetRecoveryGroupInput = struct {
    /// The name of a recovery group.
    recovery_group_name: []const u8,

    pub const json_field_names = .{
        .recovery_group_name = "RecoveryGroupName",
    };
};

pub const GetRecoveryGroupOutput = struct {
    /// A list of a cell's Amazon Resource Names (ARNs).
    cells: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) for the recovery group.
    recovery_group_arn: ?[]const u8 = null,

    /// The name of the recovery group.
    recovery_group_name: ?[]const u8 = null,

    /// The tags associated with the recovery group.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cells = "Cells",
        .recovery_group_arn = "RecoveryGroupArn",
        .recovery_group_name = "RecoveryGroupName",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecoveryGroupInput, options: CallOptions) !GetRecoveryGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53-recovery-readiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecoveryGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-readiness", "Route53 Recovery Readiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/recoverygroups/");
    try path_buf.appendSlice(allocator, input.recovery_group_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecoveryGroupOutput {
    var result: GetRecoveryGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRecoveryGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
