const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StartRecoveryRequestSourceServer = @import("start_recovery_request_source_server.zig").StartRecoveryRequestSourceServer;
const Job = @import("job.zig").Job;

pub const StartRecoveryInput = struct {
    /// Whether this Source Server Recovery operation is a drill or not.
    is_drill: ?bool = null,

    /// The Source Servers that we want to start a Recovery Job for.
    source_servers: []const StartRecoveryRequestSourceServer,

    /// The tags to be associated with the Recovery Job.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .is_drill = "isDrill",
        .source_servers = "sourceServers",
        .tags = "tags",
    };
};

pub const StartRecoveryOutput = struct {
    /// The Recovery Job.
    job: ?Job = null,

    pub const json_field_names = .{
        .job = "job",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartRecoveryInput, options: CallOptions) !StartRecoveryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "drs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartRecoveryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/StartRecovery";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.is_drill) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"isDrill\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceServers\":");
    try aws.json.writeValue(@TypeOf(input.source_servers), input.source_servers, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartRecoveryOutput {
    var result: StartRecoveryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartRecoveryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
