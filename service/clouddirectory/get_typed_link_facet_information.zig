const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetTypedLinkFacetInformationInput = struct {
    /// The unique name of the typed link facet.
    name: []const u8,

    /// The Amazon Resource Name (ARN) that is associated with the schema. For more
    /// information, see arns.
    schema_arn: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .schema_arn = "SchemaArn",
    };
};

pub const GetTypedLinkFacetInformationOutput = struct {
    /// The order of identity attributes for the facet, from most significant to
    /// least significant. The ability to filter typed
    /// links considers the order that the attributes are defined on the typed link
    /// facet. When
    /// providing ranges to typed link selection, any inexact ranges must be
    /// specified at the end. Any
    /// attributes that do not have a range specified are presumed to match the
    /// entire range. Filters
    /// are interpreted in the order of the attributes on the typed link facet, not
    /// the order in which
    /// they are supplied to any API calls. For more information about identity
    /// attributes, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    identity_attribute_order: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .identity_attribute_order = "IdentityAttributeOrder",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTypedLinkFacetInformationInput, options: CallOptions) !GetTypedLinkFacetInformationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTypedLinkFacetInformationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/typedlink/facet/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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
    try request.headers.put(allocator, "x-amz-data-partition", input.schema_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTypedLinkFacetInformationOutput {
    const result: GetTypedLinkFacetInformationOutput = try aws.json.parseJsonObject(
        GetTypedLinkFacetInformationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
