const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeNameAndValue = @import("attribute_name_and_value.zig").AttributeNameAndValue;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const TypedLinkSchemaAndFacetName = @import("typed_link_schema_and_facet_name.zig").TypedLinkSchemaAndFacetName;
const TypedLinkSpecifier = @import("typed_link_specifier.zig").TypedLinkSpecifier;

pub const AttachTypedLinkInput = struct {
    /// A set of attributes that are associated with the typed link.
    attributes: []const AttributeNameAndValue,

    /// The Amazon Resource Name (ARN) of the directory where you want to attach the
    /// typed
    /// link.
    directory_arn: []const u8,

    /// Identifies the source object that the typed link will attach to.
    source_object_reference: ObjectReference,

    /// Identifies the target object that the typed link will attach to.
    target_object_reference: ObjectReference,

    /// Identifies the typed link facet that is associated with the typed link.
    typed_link_facet: TypedLinkSchemaAndFacetName,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .directory_arn = "DirectoryArn",
        .source_object_reference = "SourceObjectReference",
        .target_object_reference = "TargetObjectReference",
        .typed_link_facet = "TypedLinkFacet",
    };
};

pub const AttachTypedLinkOutput = struct {
    /// Returns a typed link specifier as output.
    typed_link_specifier: ?TypedLinkSpecifier = null,

    pub const json_field_names = .{
        .typed_link_specifier = "TypedLinkSpecifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AttachTypedLinkInput, options: CallOptions) !AttachTypedLinkOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AttachTypedLinkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/typedlink/attach";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Attributes\":");
    try aws.json.writeValue(@TypeOf(input.attributes), input.attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceObjectReference\":");
    try aws.json.writeValue(@TypeOf(input.source_object_reference), input.source_object_reference, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TargetObjectReference\":");
    try aws.json.writeValue(@TypeOf(input.target_object_reference), input.target_object_reference, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TypedLinkFacet\":");
    try aws.json.writeValue(@TypeOf(input.typed_link_facet), input.typed_link_facet, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AttachTypedLinkOutput {
    const result: AttachTypedLinkOutput = try aws.json.parseJsonObject(
        AttachTypedLinkOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
