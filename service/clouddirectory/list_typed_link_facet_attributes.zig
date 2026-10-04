const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TypedLinkAttributeDefinition = @import("typed_link_attribute_definition.zig").TypedLinkAttributeDefinition;

pub const ListTypedLinkFacetAttributesInput = struct {
    /// The maximum number of results to retrieve.
    max_results: ?i32 = null,

    /// The unique name of the typed link facet.
    name: []const u8,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that is associated with the schema. For more
    /// information, see arns.
    schema_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .name = "Name",
        .next_token = "NextToken",
        .schema_arn = "SchemaArn",
    };
};

pub const ListTypedLinkFacetAttributesOutput = struct {
    /// An ordered set of attributes associate with the typed link.
    attributes: ?[]const TypedLinkAttributeDefinition = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTypedLinkFacetAttributesInput, options: CallOptions) !ListTypedLinkFacetAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTypedLinkFacetAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/typedlink/facet/attributes";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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
    try request.headers.put(allocator, "x-amz-data-partition", input.schema_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTypedLinkFacetAttributesOutput {
    var result: ListTypedLinkFacetAttributesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListTypedLinkFacetAttributesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
