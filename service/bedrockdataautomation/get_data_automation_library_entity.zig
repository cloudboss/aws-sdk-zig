const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityType = @import("entity_type.zig").EntityType;
const EntityDetails = @import("entity_details.zig").EntityDetails;

pub const GetDataAutomationLibraryEntityInput = struct {
    /// Unique identifier for the entity
    entity_id: []const u8,

    /// The entity type for which the entity is requested
    entity_type: EntityType,

    /// ARN generated at the server side when a DataAutomationLibrary is created
    library_arn: []const u8,

    pub const json_field_names = .{
        .entity_id = "entityId",
        .entity_type = "entityType",
        .library_arn = "libraryArn",
    };
};

pub const GetDataAutomationLibraryEntityOutput = struct {
    /// Detailed information about the entity
    entity: ?EntityDetails = null,

    pub const json_field_names = .{
        .entity = "entity",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataAutomationLibraryEntityInput, options: CallOptions) !GetDataAutomationLibraryEntityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataAutomationLibraryEntityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-data-automation", "Bedrock Data Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-automation-libraries/");
    try path_buf.appendSlice(allocator, input.library_arn);
    try path_buf.appendSlice(allocator, "/entityType/");
    try path_buf.appendSlice(allocator, input.entity_type);
    try path_buf.appendSlice(allocator, "/entities/");
    try path_buf.appendSlice(allocator, input.entity_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataAutomationLibraryEntityOutput {
    var result: GetDataAutomationLibraryEntityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataAutomationLibraryEntityOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
