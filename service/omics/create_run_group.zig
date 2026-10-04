const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateRunGroupInput = struct {
    /// The maximum number of CPUs that can run concurrently across all active runs
    /// in the run group.
    max_cpus: ?i32 = null,

    /// The maximum time for each run (in minutes). If a run exceeds the maximum run
    /// time, the run fails automatically.
    max_duration: ?i32 = null,

    /// The maximum number of GPUs that can run concurrently across all active runs
    /// in the run group.
    max_gpus: ?i32 = null,

    /// The maximum number of runs that can be running at the same time.
    max_runs: ?i32 = null,

    /// A name for the group.
    name: ?[]const u8 = null,

    /// To ensure that requests don't run multiple times, specify a unique ID for
    /// each request.
    request_id: []const u8,

    /// Tags for the group.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .max_cpus = "maxCpus",
        .max_duration = "maxDuration",
        .max_gpus = "maxGpus",
        .max_runs = "maxRuns",
        .name = "name",
        .request_id = "requestId",
        .tags = "tags",
    };
};

pub const CreateRunGroupOutput = struct {
    /// The group's ARN.
    arn: ?[]const u8 = null,

    /// The group's ID.
    id: ?[]const u8 = null,

    /// Tags for the run group.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRunGroupInput, options: CallOptions) !CreateRunGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRunGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/runGroup";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_cpus) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxCpus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxDuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_gpus) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxGpus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_runs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxRuns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"requestId\":");
    try aws.json.writeValue(@TypeOf(input.request_id), input.request_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRunGroupOutput {
    var result: CreateRunGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRunGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
