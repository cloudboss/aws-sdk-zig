const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ObjectReference = @import("object_reference.zig").ObjectReference;

pub const AttachToIndexInput = struct {
    /// The Amazon Resource Name (ARN) of the directory where the object and index
    /// exist.
    directory_arn: []const u8,

    /// A reference to the index that you are attaching the object to.
    index_reference: ObjectReference,

    /// A reference to the object that you are attaching to the index.
    target_reference: ObjectReference,

    pub const json_field_names = .{
        .directory_arn = "DirectoryArn",
        .index_reference = "IndexReference",
        .target_reference = "TargetReference",
    };
};

pub const AttachToIndexOutput = struct {
    /// The `ObjectIdentifier` of the object that was attached to the index.
    attached_object_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .attached_object_identifier = "AttachedObjectIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AttachToIndexInput, options: CallOptions) !AttachToIndexOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AttachToIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/index/attach";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IndexReference\":");
    try aws.json.writeValue(@TypeOf(input.index_reference), input.index_reference, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TargetReference\":");
    try aws.json.writeValue(@TypeOf(input.target_reference), input.target_reference, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AttachToIndexOutput {
    const result: AttachToIndexOutput = try aws.json.parseJsonObject(
        AttachToIndexOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
