const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsistencyLevel = @import("consistency_level.zig").ConsistencyLevel;
const TypedLinkSpecifier = @import("typed_link_specifier.zig").TypedLinkSpecifier;
const AttributeKeyAndValue = @import("attribute_key_and_value.zig").AttributeKeyAndValue;

pub const GetLinkAttributesInput = struct {
    /// A list of attribute names whose values will be retrieved.
    attribute_names: []const []const u8,

    /// The consistency level at which to retrieve the attributes on a typed link.
    consistency_level: ?ConsistencyLevel = null,

    /// The Amazon Resource Name (ARN) that is associated with the Directory where
    /// the typed link resides. For more information, see arns or [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    directory_arn: []const u8,

    /// Allows a typed link specifier to be accepted as input.
    typed_link_specifier: TypedLinkSpecifier,

    pub const json_field_names = .{
        .attribute_names = "AttributeNames",
        .consistency_level = "ConsistencyLevel",
        .directory_arn = "DirectoryArn",
        .typed_link_specifier = "TypedLinkSpecifier",
    };
};

pub const GetLinkAttributesOutput = struct {
    /// The attributes that are associated with the typed link.
    attributes: ?[]const AttributeKeyAndValue = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLinkAttributesInput, options: CallOptions) !GetLinkAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLinkAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/typedlink/attributes/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AttributeNames\":");
    try aws.json.writeValue(@TypeOf(input.attribute_names), input.attribute_names, allocator, &body_buf);
    has_prev = true;
    if (input.consistency_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConsistencyLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TypedLinkSpecifier\":");
    try aws.json.writeValue(@TypeOf(input.typed_link_specifier), input.typed_link_specifier, allocator, &body_buf);
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
    try request.headers.put(allocator, "x-amz-data-partition", input.directory_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLinkAttributesOutput {
    const result: GetLinkAttributesOutput = try aws.json.parseJsonObject(
        GetLinkAttributesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
