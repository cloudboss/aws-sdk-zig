const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CancellationStatus = @import("cancellation_status.zig").CancellationStatus;

pub const CancelJobInput = struct {
    /// The ARN of the Amazon Braket hybrid job to cancel.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
    };
};

pub const CancelJobOutput = struct {
    /// The status of the hybrid job.
    cancellation_status: CancellationStatus,

    /// The ARN of the Amazon Braket job.
    job_arn: []const u8,

    pub const json_field_names = .{
        .cancellation_status = "cancellationStatus",
        .job_arn = "jobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelJobInput, options: CallOptions) !CancelJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "braket", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("braket", "Braket", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/job/");
    try path_buf.appendSlice(allocator, input.job_arn);
    try path_buf.appendSlice(allocator, "/cancel");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelJobOutput {
    var result: CancelJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CancelJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
