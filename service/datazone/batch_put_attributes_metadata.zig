const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeInput = @import("attribute_input.zig").AttributeInput;
const AttributeEntityType = @import("attribute_entity_type.zig").AttributeEntityType;
const BatchPutAttributeOutput = @import("batch_put_attribute_output.zig").BatchPutAttributeOutput;
const AttributeError = @import("attribute_error.zig").AttributeError;

pub const BatchPutAttributesMetadataInput = struct {
    /// The attributes of the metadata.
    attributes: []const AttributeInput,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    /// This field is automatically populated if not provided.
    client_token: ?[]const u8 = null,

    /// The domain ID where you want to write the attribute metadata.
    domain_identifier: []const u8,

    /// The entity ID for which you want to write the attribute metadata.
    entity_identifier: []const u8,

    /// The entity type for which you want to write the attribute metadata.
    entity_type: AttributeEntityType,

    pub const json_field_names = .{
        .attributes = "attributes",
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .entity_identifier = "entityIdentifier",
        .entity_type = "entityType",
    };
};

pub const BatchPutAttributesMetadataOutput = struct {
    /// The results of the BatchPutAttributeMetadata action.
    attributes: ?[]const BatchPutAttributeOutput = null,

    /// The errors generated when the BatchPutAttributeMetadata action is invoked.
    errors: ?[]const AttributeError = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchPutAttributesMetadataInput, options: CallOptions) !BatchPutAttributesMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchPutAttributesMetadataInput, config: *aws.Config) !aws.http.Request {
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"attributes\":");
    try aws.json.writeValue(@TypeOf(input.attributes), input.attributes, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchPutAttributesMetadataOutput {
    const result: BatchPutAttributesMetadataOutput = try aws.json.parseJsonObject(
        BatchPutAttributesMetadataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
