const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsistencyLevel = @import("consistency_level.zig").ConsistencyLevel;
const TypedLinkAttributeRange = @import("typed_link_attribute_range.zig").TypedLinkAttributeRange;
const TypedLinkSchemaAndFacetName = @import("typed_link_schema_and_facet_name.zig").TypedLinkSchemaAndFacetName;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const TypedLinkSpecifier = @import("typed_link_specifier.zig").TypedLinkSpecifier;

pub const ListIncomingTypedLinksInput = struct {
    /// The consistency level to execute the request at.
    consistency_level: ?ConsistencyLevel = null,

    /// The Amazon Resource Name (ARN) of the directory where you want to list the
    /// typed
    /// links.
    directory_arn: []const u8,

    /// Provides range filters for multiple attributes. When providing ranges to
    /// typed link
    /// selection, any inexact ranges must be specified at the end. Any attributes
    /// that do not have a
    /// range specified are presumed to match the entire range.
    filter_attribute_ranges: ?[]const TypedLinkAttributeRange = null,

    /// Filters are interpreted in the order of the attributes on the typed link
    /// facet, not the
    /// order in which they are supplied to any API calls.
    filter_typed_link: ?TypedLinkSchemaAndFacetName = null,

    /// The maximum number of results to retrieve.
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// Reference that identifies the object whose attributes will be listed.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .consistency_level = "ConsistencyLevel",
        .directory_arn = "DirectoryArn",
        .filter_attribute_ranges = "FilterAttributeRanges",
        .filter_typed_link = "FilterTypedLink",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .object_reference = "ObjectReference",
    };
};

pub const ListIncomingTypedLinksOutput = struct {
    /// Returns one or more typed link specifiers as output.
    link_specifiers: ?[]const TypedLinkSpecifier = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .link_specifiers = "LinkSpecifiers",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIncomingTypedLinksInput, options: CallOptions) !ListIncomingTypedLinksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIncomingTypedLinksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/typedlink/incoming";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.consistency_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConsistencyLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_attribute_ranges) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterAttributeRanges\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_typed_link) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterTypedLink\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    try request.headers.put(allocator, "x-amz-data-partition", input.directory_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIncomingTypedLinksOutput {
    var result: ListIncomingTypedLinksOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListIncomingTypedLinksOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
