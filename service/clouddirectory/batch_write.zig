const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchWriteOperation = @import("batch_write_operation.zig").BatchWriteOperation;
const BatchWriteOperationResponse = @import("batch_write_operation_response.zig").BatchWriteOperationResponse;

pub const BatchWriteInput = struct {
    /// The Amazon Resource Name (ARN) that is associated with the Directory.
    /// For more information, see arns.
    directory_arn: []const u8,

    /// A list of operations that are part of the batch.
    operations: []const BatchWriteOperation,

    pub const json_field_names = .{
        .directory_arn = "DirectoryArn",
        .operations = "Operations",
    };
};

pub const BatchWriteOutput = struct {
    /// A list of all the responses for each batch write.
    responses: ?[]const BatchWriteOperationResponse = null,

    pub const json_field_names = .{
        .responses = "Responses",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchWriteInput, options: CallOptions) !BatchWriteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "clouddirectory", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchWriteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/batchwrite";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Operations\":");
    try aws.json.writeValue(@TypeOf(input.operations), input.operations, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amz-data-partition", input.directory_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchWriteOutput {
    var result: BatchWriteOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchWriteOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
