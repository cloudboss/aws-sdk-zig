const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsistencyLevel = @import("consistency_level.zig").ConsistencyLevel;
const ObjectReference = @import("object_reference.zig").ObjectReference;

pub const ListObjectPoliciesInput = struct {
    /// Represents the manner and timing in which the successful write or update of
    /// an object
    /// is reflected in a subsequent read operation of that same object.
    consistency_level: ?ConsistencyLevel = null,

    /// The Amazon Resource Name (ARN) that is associated with the Directory
    /// where objects reside. For more information, see arns.
    directory_arn: []const u8,

    /// The maximum number of items to be retrieved in a single call. This is an
    /// approximate
    /// number.
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// Reference that identifies the object for which policies will be listed.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .consistency_level = "ConsistencyLevel",
        .directory_arn = "DirectoryArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .object_reference = "ObjectReference",
    };
};

pub const ListObjectPoliciesOutput = struct {
    /// A list of policy `ObjectIdentifiers`, that are attached to the
    /// object.
    attached_policy_ids: ?[]const []const u8 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attached_policy_ids = "AttachedPolicyIds",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListObjectPoliciesInput, options: CallOptions) !ListObjectPoliciesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListObjectPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/object/policy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ObjectReference\":");
    try aws.json.writeValue(@TypeOf(input.object_reference), input.object_reference, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListObjectPoliciesOutput {
    const result: ListObjectPoliciesOutput = try aws.json.parseJsonObject(
        ListObjectPoliciesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
