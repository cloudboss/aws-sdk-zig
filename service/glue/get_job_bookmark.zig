const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobBookmarkEntry = @import("job_bookmark_entry.zig").JobBookmarkEntry;

pub const GetJobBookmarkInput = struct {
    /// The name of the job in question.
    job_name: []const u8,

    /// The unique run identifier associated with this job run.
    run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_name = "JobName",
        .run_id = "RunId",
    };
};

pub const GetJobBookmarkOutput = struct {
    /// A structure that defines a point that a job can resume processing.
    job_bookmark_entry: ?JobBookmarkEntry = null,

    pub const json_field_names = .{
        .job_bookmark_entry = "JobBookmarkEntry",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetJobBookmarkInput, options: CallOptions) !GetJobBookmarkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetJobBookmarkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetJobBookmark");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetJobBookmarkOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetJobBookmarkOutput, body, allocator);
}
