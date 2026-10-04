const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateReadinessCheckInput = struct {
    /// The name of the readiness check to create.
    readiness_check_name: []const u8,

    /// The name of the resource set to check.
    resource_set_name: []const u8,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .readiness_check_name = "ReadinessCheckName",
        .resource_set_name = "ResourceSetName",
        .tags = "Tags",
    };
};

pub const CreateReadinessCheckOutput = struct {
    /// The Amazon Resource Name (ARN) associated with a readiness check.
    readiness_check_arn: ?[]const u8 = null,

    /// Name of a readiness check.
    readiness_check_name: ?[]const u8 = null,

    /// Name of the resource set to be checked.
    resource_set: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .readiness_check_arn = "ReadinessCheckArn",
        .readiness_check_name = "ReadinessCheckName",
        .resource_set = "ResourceSet",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReadinessCheckInput, options: CallOptions) !CreateReadinessCheckOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReadinessCheckInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-readiness", "Route53 Recovery Readiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/readinesschecks";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ReadinessCheckName\":");
    try aws.json.writeValue(@TypeOf(input.readiness_check_name), input.readiness_check_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceSetName\":");
    try aws.json.writeValue(@TypeOf(input.resource_set_name), input.resource_set_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReadinessCheckOutput {
    var result: CreateReadinessCheckOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateReadinessCheckOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
