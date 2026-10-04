const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsistencyLevel = @import("consistency_level.zig").ConsistencyLevel;
const BatchReadOperation = @import("batch_read_operation.zig").BatchReadOperation;
const BatchReadOperationResponse = @import("batch_read_operation_response.zig").BatchReadOperationResponse;

pub const BatchReadInput = struct {
    /// Represents the manner and timing in which the successful write or update of
    /// an object
    /// is reflected in a subsequent read operation of that same object.
    consistency_level: ?ConsistencyLevel = null,

    /// The Amazon Resource Name (ARN) that is associated with the Directory.
    /// For more information, see arns.
    directory_arn: []const u8,

    /// A list of operations that are part of the batch.
    operations: []const BatchReadOperation,

    pub const json_field_names = .{
        .consistency_level = "ConsistencyLevel",
        .directory_arn = "DirectoryArn",
        .operations = "Operations",
    };
};

pub const BatchReadOutput = struct {
    /// A list of all the responses for each batch read.
    responses: ?[]const BatchReadOperationResponse = null,

    pub const json_field_names = .{
        .responses = "Responses",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchReadInput, options: CallOptions) !BatchReadOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchReadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/batchread";

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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.consistency_level) |v| {
        try request.headers.put(allocator, "x-amz-consistency-level", v.wireName());
    }
    try request.headers.put(allocator, "x-amz-data-partition", input.directory_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchReadOutput {
    const result: BatchReadOutput = try aws.json.parseJsonObject(
        BatchReadOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
