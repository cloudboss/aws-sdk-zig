const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Authorization = @import("authorization.zig").Authorization;
const EgressAccessLogs = @import("egress_access_logs.zig").EgressAccessLogs;

pub const CreatePackagingGroupInput = struct {
    authorization: ?Authorization = null,

    egress_access_logs: ?EgressAccessLogs = null,

    /// The ID of the PackagingGroup.
    id: []const u8,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .authorization = "Authorization",
        .egress_access_logs = "EgressAccessLogs",
        .id = "Id",
        .tags = "Tags",
    };
};

pub const CreatePackagingGroupOutput = struct {
    /// The ARN of the PackagingGroup.
    arn: ?[]const u8 = null,

    authorization: ?Authorization = null,

    /// The time the PackagingGroup was created.
    created_at: ?[]const u8 = null,

    /// The fully qualified domain name for Assets in the PackagingGroup.
    domain_name: ?[]const u8 = null,

    egress_access_logs: ?EgressAccessLogs = null,

    /// The ID of the PackagingGroup.
    id: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .authorization = "Authorization",
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .egress_access_logs = "EgressAccessLogs",
        .id = "Id",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePackagingGroupInput, options: CallOptions) !CreatePackagingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediapackage-vod", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePackagingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackage-vod", "MediaPackage Vod", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/packaging_groups";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.authorization) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Authorization\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.egress_access_logs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EgressAccessLogs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Id\":");
    try aws.json.writeValue(@TypeOf(input.id), input.id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePackagingGroupOutput {
    var result: CreatePackagingGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePackagingGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
