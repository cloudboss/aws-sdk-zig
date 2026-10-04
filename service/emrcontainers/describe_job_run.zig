const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobRun = @import("job_run.zig").JobRun;

pub const DescribeJobRunInput = struct {
    /// The ID of the job run request.
    id: []const u8,

    /// The ID of the virtual cluster for which the job run is submitted.
    virtual_cluster_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .virtual_cluster_id = "virtualClusterId",
    };
};

pub const DescribeJobRunOutput = struct {
    /// The output displays information about a job run.
    job_run: ?JobRun = null,

    pub const json_field_names = .{
        .job_run = "jobRun",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeJobRunInput, options: CallOptions) !DescribeJobRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "emr-containers", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeJobRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr-containers", "EMR containers", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/virtualclusters/");
    try path_buf.appendSlice(allocator, input.virtual_cluster_id);
    try path_buf.appendSlice(allocator, "/jobruns/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeJobRunOutput {
    const result: DescribeJobRunOutput = try aws.json.parseJsonObject(
        DescribeJobRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
