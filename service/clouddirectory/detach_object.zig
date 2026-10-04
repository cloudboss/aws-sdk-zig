const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ObjectReference = @import("object_reference.zig").ObjectReference;

pub const DetachObjectInput = struct {
    /// The Amazon Resource Name (ARN) that is associated with the Directory
    /// where objects reside. For more information, see arns.
    directory_arn: []const u8,

    /// The link name associated with the object that needs to be detached.
    link_name: []const u8,

    /// The parent reference from which the object with the specified link name is
    /// detached.
    parent_reference: ObjectReference,

    pub const json_field_names = .{
        .directory_arn = "DirectoryArn",
        .link_name = "LinkName",
        .parent_reference = "ParentReference",
    };
};

pub const DetachObjectOutput = struct {
    /// The `ObjectIdentifier` that was detached from the object.
    detached_object_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .detached_object_identifier = "DetachedObjectIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetachObjectInput, options: CallOptions) !DetachObjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetachObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/object/detach";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LinkName\":");
    try aws.json.writeValue(@TypeOf(input.link_name), input.link_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ParentReference\":");
    try aws.json.writeValue(@TypeOf(input.parent_reference), input.parent_reference, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetachObjectOutput {
    var result: DetachObjectOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DetachObjectOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
