const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FacetAttribute = @import("facet_attribute.zig").FacetAttribute;
const FacetStyle = @import("facet_style.zig").FacetStyle;
const ObjectType = @import("object_type.zig").ObjectType;

pub const CreateFacetInput = struct {
    /// The attributes that are associated with the Facet.
    attributes: ?[]const FacetAttribute = null,

    /// There are two different styles that you can define on any given facet,
    /// `Static` and `Dynamic`. For static facets, all attributes must be defined in
    /// the schema. For dynamic facets, attributes can be defined during data plane
    /// operations.
    facet_style: ?FacetStyle = null,

    /// The name of the Facet, which is unique for a given schema.
    name: []const u8,

    /// Specifies whether a given object created from this facet is of type node,
    /// leaf node,
    /// policy or index.
    ///
    /// * Node: Can have multiple children but one parent.
    ///
    /// * Leaf node: Cannot have children but can have multiple parents.
    ///
    /// * Policy: Allows you to store a policy document and policy type. For more
    /// information, see
    /// [Policies](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/key_concepts_directory.html#key_concepts_policies).
    ///
    /// * Index: Can be created with the Index API.
    object_type: ?ObjectType = null,

    /// The schema ARN in which the new Facet will be created. For more
    /// information, see arns.
    schema_arn: []const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .facet_style = "FacetStyle",
        .name = "Name",
        .object_type = "ObjectType",
        .schema_arn = "SchemaArn",
    };
};

pub const CreateFacetOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFacetInput, options: CallOptions) !CreateFacetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFacetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/facet/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.facet_style) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FacetStyle\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFacetOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateFacetOutput = .{};

    return result;
}
