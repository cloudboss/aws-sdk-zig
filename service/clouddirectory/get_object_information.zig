const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsistencyLevel = @import("consistency_level.zig").ConsistencyLevel;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const SchemaFacet = @import("schema_facet.zig").SchemaFacet;

pub const GetObjectInformationInput = struct {
    /// The consistency level at which to retrieve the object information.
    consistency_level: ?ConsistencyLevel = null,

    /// The ARN of the directory being retrieved.
    directory_arn: []const u8,

    /// A reference to the object.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .consistency_level = "ConsistencyLevel",
        .directory_arn = "DirectoryArn",
        .object_reference = "ObjectReference",
    };
};

pub const GetObjectInformationOutput = struct {
    /// The `ObjectIdentifier` of the specified object.
    object_identifier: ?[]const u8 = null,

    /// The facets attached to the specified object. Although the response does not
    /// include minor version information, the most recently applied minor version
    /// of each Facet is in effect. See GetAppliedSchemaVersion for details.
    schema_facets: ?[]const SchemaFacet = null,

    pub const json_field_names = .{
        .object_identifier = "ObjectIdentifier",
        .schema_facets = "SchemaFacets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetObjectInformationInput, options: CallOptions) !GetObjectInformationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetObjectInformationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/object/information";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.consistency_level) |v| {
        try request.headers.put(allocator, "x-amz-consistency-level", v.wireName());
    }
    try request.headers.put(allocator, "x-amz-data-partition", input.directory_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetObjectInformationOutput {
    var result: GetObjectInformationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetObjectInformationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
