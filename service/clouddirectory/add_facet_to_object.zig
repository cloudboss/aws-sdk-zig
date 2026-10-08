const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeKeyAndValue = @import("attribute_key_and_value.zig").AttributeKeyAndValue;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const SchemaFacet = @import("schema_facet.zig").SchemaFacet;

pub const AddFacetToObjectInput = struct {
    /// The Amazon Resource Name (ARN) that is associated with the Directory
    /// where the object resides. For more information, see arns.
    directory_arn: []const u8,

    /// Attributes on the facet that you are adding to the object.
    object_attribute_list: ?[]const AttributeKeyAndValue = null,

    /// A reference to the object you are adding the specified facet to.
    object_reference: ObjectReference,

    /// Identifiers for the facet that you are adding to the object. See SchemaFacet
    /// for details.
    schema_facet: SchemaFacet,

    pub const json_field_names = .{
        .directory_arn = "DirectoryArn",
        .object_attribute_list = "ObjectAttributeList",
        .object_reference = "ObjectReference",
        .schema_facet = "SchemaFacet",
    };
};

pub const AddFacetToObjectOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddFacetToObjectInput, options: CallOptions) !AddFacetToObjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddFacetToObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/object/facets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.object_attribute_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ObjectAttributeList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amz-data-partition", input.directory_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddFacetToObjectOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AddFacetToObjectOutput = .{};

    return result;
}
