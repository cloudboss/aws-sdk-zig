const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FacetAttributeUpdate = @import("facet_attribute_update.zig").FacetAttributeUpdate;
const ObjectType = @import("object_type.zig").ObjectType;

pub const UpdateFacetInput = struct {
    /// List of attributes that need to be updated in a given schema Facet.
    /// Each attribute is followed by `AttributeAction`, which specifies the type of
    /// update
    /// operation to perform.
    attribute_updates: ?[]const FacetAttributeUpdate = null,

    /// The name of the facet.
    name: []const u8,

    /// The object type that is associated with the facet. See
    /// CreateFacetRequest$ObjectType for more details.
    object_type: ?ObjectType = null,

    /// The Amazon Resource Name (ARN) that is associated with the Facet.
    /// For more information, see arns.
    schema_arn: []const u8,

    pub const json_field_names = .{
        .attribute_updates = "AttributeUpdates",
        .name = "Name",
        .object_type = "ObjectType",
        .schema_arn = "SchemaArn",
    };
};

pub const UpdateFacetOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFacetInput, options: CallOptions) !UpdateFacetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFacetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/facet";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attribute_updates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AttributeUpdates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.object_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ObjectType\":");
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
    try request.headers.put(allocator, "x-amz-data-partition", input.schema_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFacetOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateFacetOutput = .{};

    return result;
}
