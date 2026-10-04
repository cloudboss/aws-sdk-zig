const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceDefinitionVersion = @import("resource_definition_version.zig").ResourceDefinitionVersion;

pub const GetResourceDefinitionVersionInput = struct {
    /// The ID of the resource definition.
    resource_definition_id: []const u8,

    /// The ID of the resource definition version. This value maps to the
    /// ''Version'' property of the corresponding ''VersionInformation'' object,
    /// which is returned by ''ListResourceDefinitionVersions'' requests. If the
    /// version is the last one that was associated with a resource definition, the
    /// value also maps to the ''LatestVersion'' property of the corresponding
    /// ''DefinitionInformation'' object.
    resource_definition_version_id: []const u8,

    pub const json_field_names = .{
        .resource_definition_id = "ResourceDefinitionId",
        .resource_definition_version_id = "ResourceDefinitionVersionId",
    };
};

pub const GetResourceDefinitionVersionOutput = struct {
    /// Arn of the resource definition version.
    arn: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the resource definition
    /// version was created.
    creation_timestamp: ?[]const u8 = null,

    /// Information about the definition.
    definition: ?ResourceDefinitionVersion = null,

    /// The ID of the resource definition version.
    id: ?[]const u8 = null,

    /// The version of the resource definition version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_timestamp = "CreationTimestamp",
        .definition = "Definition",
        .id = "Id",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceDefinitionVersionInput, options: CallOptions) !GetResourceDefinitionVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceDefinitionVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/definition/resources/");
    try path_buf.appendSlice(allocator, input.resource_definition_id);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.resource_definition_version_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceDefinitionVersionOutput {
    var result: GetResourceDefinitionVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourceDefinitionVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
