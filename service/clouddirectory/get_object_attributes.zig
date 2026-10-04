const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsistencyLevel = @import("consistency_level.zig").ConsistencyLevel;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const SchemaFacet = @import("schema_facet.zig").SchemaFacet;
const AttributeKeyAndValue = @import("attribute_key_and_value.zig").AttributeKeyAndValue;

pub const GetObjectAttributesInput = struct {
    /// List of attribute names whose values will be retrieved.
    attribute_names: []const []const u8,

    /// The consistency level at which to retrieve the attributes on an object.
    consistency_level: ?ConsistencyLevel = null,

    /// The Amazon Resource Name (ARN) that is associated with the Directory where
    /// the object resides.
    directory_arn: []const u8,

    /// Reference that identifies the object whose attributes will be retrieved.
    object_reference: ObjectReference,

    /// Identifier for the facet whose attributes will be retrieved. See SchemaFacet
    /// for details.
    schema_facet: SchemaFacet,

    pub const json_field_names = .{
        .attribute_names = "AttributeNames",
        .consistency_level = "ConsistencyLevel",
        .directory_arn = "DirectoryArn",
        .object_reference = "ObjectReference",
        .schema_facet = "SchemaFacet",
    };
};

pub const GetObjectAttributesOutput = struct {
    /// The attributes that are associated with the object.
    attributes: ?[]const AttributeKeyAndValue = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetObjectAttributesInput, options: CallOptions) !GetObjectAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetObjectAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/object/attributes/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AttributeNames\":");
    try aws.json.writeValue(@TypeOf(input.attribute_names), input.attribute_names, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ObjectReference\":");
    try aws.json.writeValue(@TypeOf(input.object_reference), input.object_reference, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SchemaFacet\":");
    try aws.json.writeValue(@TypeOf(input.schema_facet), input.schema_facet, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetObjectAttributesOutput {
    const result: GetObjectAttributesOutput = try aws.json.parseJsonObject(
        GetObjectAttributesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
