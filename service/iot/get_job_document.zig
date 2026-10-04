const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetJobDocumentInput = struct {
    /// Provides a view of the job document before and after the substitution
    /// parameters have been resolved with their exact values.
    before_substitution: ?bool = null,

    /// The unique identifier you assigned to this job when it was created.
    job_id: []const u8,

    pub const json_field_names = .{
        .before_substitution = "beforeSubstitution",
        .job_id = "jobId",
    };
};

pub const GetJobDocumentOutput = struct {
    /// The job document content.
    document: ?[]const u8 = null,

    pub const json_field_names = .{
        .document = "document",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetJobDocumentInput, options: CallOptions) !GetJobDocumentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetJobDocumentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    try path_buf.appendSlice(allocator, "/job-document");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.before_substitution) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "beforeSubstitution=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetJobDocumentOutput {
    var result: GetJobDocumentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetJobDocumentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
