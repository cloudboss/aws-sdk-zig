const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsistencyLevel = @import("consistency_level.zig").ConsistencyLevel;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const ObjectAttributeRange = @import("object_attribute_range.zig").ObjectAttributeRange;
const IndexAttachment = @import("index_attachment.zig").IndexAttachment;

pub const ListIndexInput = struct {
    /// The consistency level to execute the request at.
    consistency_level: ?ConsistencyLevel = null,

    /// The ARN of the directory that the index exists in.
    directory_arn: []const u8,

    /// The reference to the index to list.
    index_reference: ObjectReference,

    /// The maximum number of objects in a single page to retrieve from the index
    /// during a request. For more information, see [Amazon Cloud Directory
    /// Limits](http://docs.aws.amazon.com/clouddirectory/latest/developerguide/limits.html).
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// Specifies the ranges of indexed values that you want to query.
    ranges_on_indexed_values: ?[]const ObjectAttributeRange = null,

    pub const json_field_names = .{
        .consistency_level = "ConsistencyLevel",
        .directory_arn = "DirectoryArn",
        .index_reference = "IndexReference",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .ranges_on_indexed_values = "RangesOnIndexedValues",
    };
};

pub const ListIndexOutput = struct {
    /// The objects and indexed values attached to the index.
    index_attachments: ?[]const IndexAttachment = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_attachments = "IndexAttachments",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIndexInput, options: CallOptions) !ListIndexOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/index/targets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IndexReference\":");
    try aws.json.writeValue(@TypeOf(input.index_reference), input.index_reference, allocator, &body_buf);
    has_prev = true;
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
    if (input.ranges_on_indexed_values) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RangesOnIndexedValues\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIndexOutput {
    var result: ListIndexOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListIndexOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
