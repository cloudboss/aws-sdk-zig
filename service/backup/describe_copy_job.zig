const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CopyJob = @import("copy_job.zig").CopyJob;

pub const DescribeCopyJobInput = struct {
    /// Uniquely identifies a copy job.
    copy_job_id: []const u8,

    pub const json_field_names = .{
        .copy_job_id = "CopyJobId",
    };
};

pub const DescribeCopyJobOutput = struct {
    /// Contains detailed information about a copy job.
    copy_job: ?CopyJob = null,

    pub const json_field_names = .{
        .copy_job = "CopyJob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCopyJobInput, options: CallOptions) !DescribeCopyJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCopyJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/copy-jobs/");
    try path_buf.appendSlice(allocator, input.copy_job_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCopyJobOutput {
    var result: DescribeCopyJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeCopyJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
