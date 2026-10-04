const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RunType = @import("run_type.zig").RunType;
const CanaryRun = @import("canary_run.zig").CanaryRun;

pub const GetCanaryRunsInput = struct {
    /// The DryRunId associated with an existing canary’s dry run. You can use this
    /// DryRunId to retrieve information about the dry run.
    dry_run_id: ?[]const u8 = null,

    /// Specify this parameter to limit how many runs are returned each time you use
    /// the `GetCanaryRuns` operation. If you omit this parameter, the default of
    /// 100 is used.
    max_results: ?i32 = null,

    /// The name of the canary that you want to see runs for.
    name: []const u8,

    /// A token that indicates that there is more data
    /// available. You can use this token in a subsequent `GetCanaryRuns` operation
    /// to retrieve the next
    /// set of results.
    ///
    /// When auto retry is enabled for the canary, the first subsequent retry is
    /// suffixed with *1 indicating its the first retry and the next subsequent try
    /// is suffixed with *2.
    next_token: ?[]const u8 = null,

    /// * When you provide `RunType=CANARY_RUN` and `dryRunId`, you will get an
    ///   exception
    ///
    /// * When a value is not provided for `RunType`, the default value is
    ///   `CANARY_RUN`
    ///
    /// * When `CANARY_RUN` is provided, all canary runs excluding dry runs are
    ///   returned
    ///
    /// * When `DRY_RUN` is provided, all dry runs excluding canary runs are
    ///   returned
    run_type: ?RunType = null,

    pub const json_field_names = .{
        .dry_run_id = "DryRunId",
        .max_results = "MaxResults",
        .name = "Name",
        .next_token = "NextToken",
        .run_type = "RunType",
    };
};

pub const GetCanaryRunsOutput = struct {
    /// An array of structures. Each structure contains the details of one of the
    /// retrieved canary runs.
    canary_runs: ?[]const CanaryRun = null,

    /// A token that indicates that there is more data
    /// available. You can use this token in a subsequent `GetCanaryRuns`
    /// operation to retrieve the next
    /// set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .canary_runs = "CanaryRuns",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCanaryRunsInput, options: CallOptions) !GetCanaryRunsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "synthetics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCanaryRunsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("synthetics", "synthetics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/canary/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/runs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.dry_run_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DryRunId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.run_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RunType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCanaryRunsOutput {
    var result: GetCanaryRunsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCanaryRunsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
