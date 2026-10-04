const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetWorkerIdentifier = @import("batch_get_worker_identifier.zig").BatchGetWorkerIdentifier;
const BatchGetWorkerError = @import("batch_get_worker_error.zig").BatchGetWorkerError;
const BatchGetWorkerItem = @import("batch_get_worker_item.zig").BatchGetWorkerItem;

pub const BatchGetWorkerInput = struct {
    /// The list of worker identifiers to retrieve. You can specify up to 100
    /// identifiers per request.
    identifiers: []const BatchGetWorkerIdentifier,

    pub const json_field_names = .{
        .identifiers = "identifiers",
    };
};

pub const BatchGetWorkerOutput = struct {
    /// A list of errors for workers that could not be retrieved.
    errors: ?[]const BatchGetWorkerError = null,

    /// A list of workers that were successfully retrieved.
    workers: ?[]const BatchGetWorkerItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .workers = "workers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetWorkerInput, options: CallOptions) !BatchGetWorkerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetWorkerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2023-10-12/batch-get-worker";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"identifiers\":");
    try aws.json.writeValue(@TypeOf(input.identifiers), input.identifiers, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetWorkerOutput {
    var result: BatchGetWorkerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetWorkerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
