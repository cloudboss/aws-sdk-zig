const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeKeyAndValue = @import("attribute_key_and_value.zig").AttributeKeyAndValue;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const SchemaFacet = @import("schema_facet.zig").SchemaFacet;

pub const CreateObjectInput = struct {
    /// The Amazon Resource Name (ARN) that is associated with the Directory
    /// in which the object will be created. For more information, see arns.
    directory_arn: []const u8,

    /// The name of link that is used to attach this object to a parent.
    link_name: ?[]const u8 = null,

    /// The attribute map whose attribute ARN contains the key and attribute value
    /// as the map
    /// value.
    object_attribute_list: ?[]const AttributeKeyAndValue = null,

    /// If specified, the parent reference to which this object will be attached.
    parent_reference: ?ObjectReference = null,

    /// A list of schema facets to be associated with the object. Do not provide
    /// minor version components. See SchemaFacet for details.
    schema_facets: []const SchemaFacet,

    pub const json_field_names = .{
        .directory_arn = "DirectoryArn",
        .link_name = "LinkName",
        .object_attribute_list = "ObjectAttributeList",
        .parent_reference = "ParentReference",
        .schema_facets = "SchemaFacets",
    };
};

pub const CreateObjectOutput = struct {
    /// The identifier that is associated with the object.
    object_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .object_identifier = "ObjectIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateObjectInput, options: CallOptions) !CreateObjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/object";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.link_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LinkName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.object_attribute_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ObjectAttributeList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_reference) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ParentReference\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SchemaFacets\":");
    try aws.json.writeValue(@TypeOf(input.schema_facets), input.schema_facets, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateObjectOutput {
    const result: CreateObjectOutput = try aws.json.parseJsonObject(
        CreateObjectOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
