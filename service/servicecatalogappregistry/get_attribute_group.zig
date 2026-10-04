const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetAttributeGroupInput = struct {
    /// The name, ID, or ARN
    /// of the attribute group
    /// that holds the attributes
    /// to describe the application.
    attribute_group: []const u8,

    pub const json_field_names = .{
        .attribute_group = "attributeGroup",
    };
};

pub const GetAttributeGroupOutput = struct {
    /// The Amazon resource name (ARN) that specifies the attribute group across
    /// services.
    arn: ?[]const u8 = null,

    /// A JSON string in the form of nested key-value pairs that represent the
    /// attributes in the group and describes an application and its components.
    attributes: ?[]const u8 = null,

    /// The service principal that created the attribute group.
    created_by: ?[]const u8 = null,

    /// The ISO-8601 formatted timestamp of the moment the attribute group was
    /// created.
    creation_time: ?i64 = null,

    /// The description of the attribute group that the user provides.
    description: ?[]const u8 = null,

    /// The identifier of the attribute group.
    id: ?[]const u8 = null,

    /// The ISO-8601 formatted timestamp of the moment the attribute group was last
    /// updated. This time is the same as the creationTime for a newly created
    /// attribute group.
    last_update_time: ?i64 = null,

    /// The name of the attribute group.
    name: ?[]const u8 = null,

    /// Key-value pairs associated with the attribute group.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .attributes = "attributes",
        .created_by = "createdBy",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .last_update_time = "lastUpdateTime",
        .name = "name",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAttributeGroupInput, options: CallOptions) !GetAttributeGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAttributeGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog-appregistry", "Service Catalog AppRegistry", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/attribute-groups/");
    try path_buf.appendSlice(allocator, input.attribute_group);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAttributeGroupOutput {
    var result: GetAttributeGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAttributeGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
