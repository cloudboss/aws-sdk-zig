const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeEntityType = @import("attribute_entity_type.zig").AttributeEntityType;
const BatchGetAttributeOutput = @import("batch_get_attribute_output.zig").BatchGetAttributeOutput;
const AttributeError = @import("attribute_error.zig").AttributeError;

pub const BatchGetAttributesMetadataInput = struct {
    /// The attribute identifier.
    attribute_identifiers: []const []const u8,

    /// The domain ID where you want to get the attribute metadata.
    domain_identifier: []const u8,

    /// The entity ID for which you want to get attribute metadata.
    entity_identifier: []const u8,

    /// The entity revision for which you want to get attribute metadata.
    entity_revision: ?[]const u8 = null,

    /// The entity type for which you want to get attribute metadata.
    entity_type: AttributeEntityType,

    pub const json_field_names = .{
        .attribute_identifiers = "attributeIdentifiers",
        .domain_identifier = "domainIdentifier",
        .entity_identifier = "entityIdentifier",
        .entity_revision = "entityRevision",
        .entity_type = "entityType",
    };
};

pub const BatchGetAttributesMetadataOutput = struct {
    /// The results of the BatchGetAttributesMetadata action.
    attributes: ?[]const BatchGetAttributeOutput = null,

    /// The errors generated when the BatchGetAttributesMetadata action is invoked.
    errors: ?[]const AttributeError = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetAttributesMetadataInput, options: CallOptions) !BatchGetAttributesMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetAttributesMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/entities/");
    try path_buf.appendSlice(allocator, input.entity_type.wireName());
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.entity_identifier);
    try path_buf.appendSlice(allocator, "/attributes-metadata");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    for (input.attribute_identifiers) |item| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "attributeIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, item);
        query_has_prev = true;
    }
    if (input.entity_revision) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "entityRevision=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetAttributesMetadataOutput {
    const result: BatchGetAttributesMetadataOutput = try aws.json.parseJsonObject(
        BatchGetAttributesMetadataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
