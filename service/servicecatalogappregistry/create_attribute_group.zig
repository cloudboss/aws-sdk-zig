const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeGroup = @import("attribute_group.zig").AttributeGroup;

pub const CreateAttributeGroupInput = struct {
    /// A JSON string in the form of nested key-value pairs that represent the
    /// attributes in the group and describes an application and its components.
    attributes: []const u8,

    /// A unique identifier that you provide to ensure idempotency. If you retry a
    /// request that
    /// completed successfully using the same client token and the same parameters,
    /// the retry succeeds
    /// without performing any further actions. If you retry a successful request
    /// using the same
    /// client token, but one or more of the parameters are different, the retry
    /// fails.
    client_token: []const u8,

    /// The description of the attribute group that the user provides.
    description: ?[]const u8 = null,

    /// The name of the attribute group.
    name: []const u8,

    /// Key-value pairs you can use to associate with the attribute group.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateAttributeGroupOutput = struct {
    /// Information about the attribute group.
    attribute_group: ?AttributeGroup = null,

    pub const json_field_names = .{
        .attribute_group = "attributeGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAttributeGroupInput, options: CallOptions) !CreateAttributeGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAttributeGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog-appregistry", "Service Catalog AppRegistry", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/attribute-groups";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"attributes\":");
    try aws.json.writeValue(@TypeOf(input.attributes), input.attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAttributeGroupOutput {
    var result: CreateAttributeGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAttributeGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
