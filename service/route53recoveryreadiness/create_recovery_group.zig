const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateRecoveryGroupInput = struct {
    /// A list of the cell Amazon Resource Names (ARNs) in the recovery group.
    cells: ?[]const []const u8 = null,

    /// The name of the recovery group to create.
    recovery_group_name: []const u8,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cells = "Cells",
        .recovery_group_name = "RecoveryGroupName",
        .tags = "Tags",
    };
};

pub const CreateRecoveryGroupOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRecoveryGroupInput, options: CallOptions) !CreateRecoveryGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRecoveryGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-readiness", "Route53 Recovery Readiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/recoverygroups";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cells) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Cells\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RecoveryGroupName\":");
    try aws.json.writeValue(@TypeOf(input.recovery_group_name), input.recovery_group_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRecoveryGroupOutput {
    const result: CreateRecoveryGroupOutput = try aws.json.parseJsonObject(
        CreateRecoveryGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
