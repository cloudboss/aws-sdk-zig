const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeKey = @import("attribute_key.zig").AttributeKey;
const ObjectReference = @import("object_reference.zig").ObjectReference;

pub const CreateIndexInput = struct {
    /// The ARN of the directory where the index should be created.
    directory_arn: []const u8,

    /// Indicates whether the attribute that is being indexed has unique values or
    /// not.
    is_unique: ?bool = null,

    /// The name of the link between the parent object and the index object.
    link_name: ?[]const u8 = null,

    /// Specifies the attributes that should be indexed on. Currently only a single
    /// attribute
    /// is supported.
    ordered_indexed_attribute_list: []const AttributeKey,

    /// A reference to the parent object that contains the index object.
    parent_reference: ?ObjectReference = null,

    pub const json_field_names = .{
        .directory_arn = "DirectoryArn",
        .is_unique = "IsUnique",
        .link_name = "LinkName",
        .ordered_indexed_attribute_list = "OrderedIndexedAttributeList",
        .parent_reference = "ParentReference",
    };
};

pub const CreateIndexOutput = struct {
    /// The `ObjectIdentifier` of the index created by this operation.
    object_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .object_identifier = "ObjectIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIndexInput, options: CallOptions) !CreateIndexOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/index";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IsUnique\":");
    try aws.json.writeValue(@TypeOf(input.is_unique), input.is_unique, allocator, &body_buf);
    has_prev = true;
    if (input.link_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LinkName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OrderedIndexedAttributeList\":");
    try aws.json.writeValue(@TypeOf(input.ordered_indexed_attribute_list), input.ordered_indexed_attribute_list, allocator, &body_buf);
    has_prev = true;
    if (input.parent_reference) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ParentReference\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIndexOutput {
    var result: CreateIndexOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateIndexOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
