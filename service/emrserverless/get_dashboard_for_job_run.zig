const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetDashboardForJobRunInput = struct {
    /// Allows access to system profile logs for Lake Formation-enabled jobs.
    /// Default is false.
    access_system_profile_logs: ?bool = null,

    /// The ID of the application.
    application_id: []const u8,

    /// An optimal parameter that indicates the amount of attempts for the job. If
    /// not specified, this value defaults to the attempt of the latest job.
    attempt: ?i32 = null,

    /// The ID of the job run.
    job_run_id: []const u8,

    pub const json_field_names = .{
        .access_system_profile_logs = "accessSystemProfileLogs",
        .application_id = "applicationId",
        .attempt = "attempt",
        .job_run_id = "jobRunId",
    };
};

pub const GetDashboardForJobRunOutput = struct {
    /// The URL to view job run's dashboard.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "url",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDashboardForJobRunInput, options: CallOptions) !GetDashboardForJobRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "emr-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDashboardForJobRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr-serverless", "EMR Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/jobruns/");
    try path_buf.appendSlice(allocator, input.job_run_id);
    try path_buf.appendSlice(allocator, "/dashboard");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.access_system_profile_logs) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "accessSystemProfileLogs=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.attempt) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "attempt=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDashboardForJobRunOutput {
    const result: GetDashboardForJobRunOutput = try aws.json.parseJsonObject(
        GetDashboardForJobRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
