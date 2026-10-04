const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityType = @import("entity_type.zig").EntityType;
const DataAutomationLibraryEntitySummary = @import("data_automation_library_entity_summary.zig").DataAutomationLibraryEntitySummary;

pub const ListDataAutomationLibraryEntitiesInput = struct {
    /// The entity type for which the entity list is requested
    entity_type: EntityType,

    /// ARN generated at the server side when a DataAutomationLibrary is created
    library_arn: []const u8,

    max_results: ?i32 = null,

    /// Pagination token for retrieving the next set of results
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entity_type = "entityType",
        .library_arn = "libraryArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListDataAutomationLibraryEntitiesOutput = struct {
    /// List of entities
    entities: ?[]const DataAutomationLibraryEntitySummary = null,

    /// Pagination token for retrieving the next set of results
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entities = "entities",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataAutomationLibraryEntitiesInput, options: CallOptions) !ListDataAutomationLibraryEntitiesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataAutomationLibraryEntitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-data-automation", "Bedrock Data Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-automation-libraries/");
    try path_buf.appendSlice(allocator, input.library_arn);
    try path_buf.appendSlice(allocator, "/entityType/");
    try path_buf.appendSlice(allocator, input.entity_type);
    try path_buf.appendSlice(allocator, "/entities/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataAutomationLibraryEntitiesOutput {
    var result: ListDataAutomationLibraryEntitiesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDataAutomationLibraryEntitiesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
