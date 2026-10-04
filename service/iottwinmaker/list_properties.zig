const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PropertySummary = @import("property_summary.zig").PropertySummary;

pub const ListPropertiesInput = struct {
    /// The name of the component whose properties are returned by the operation.
    component_name: ?[]const u8 = null,

    /// This string specifies the path to the composite component, starting from the
    /// top-level component.
    component_path: ?[]const u8 = null,

    /// The ID for the entity whose metadata (component/properties) is returned by
    /// the operation.
    entity_id: []const u8,

    /// The maximum number of results returned at one time. The default is 25.
    max_results: ?i32 = null,

    /// The string that specifies the next page of results.
    next_token: ?[]const u8 = null,

    /// The workspace ID.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .component_name = "componentName",
        .component_path = "componentPath",
        .entity_id = "entityId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .workspace_id = "workspaceId",
    };
};

pub const ListPropertiesOutput = struct {
    /// The string that specifies the next page of property results.
    next_token: ?[]const u8 = null,

    /// A list of objects that contain information about the properties.
    property_summaries: ?[]const PropertySummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .property_summaries = "propertySummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPropertiesInput, options: CallOptions) !ListPropertiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsiottwinmaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPropertiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/properties-list");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.component_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"componentName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.component_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"componentPath\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entityId\":");
    try aws.json.writeValue(@TypeOf(input.entity_id), input.entity_id, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPropertiesOutput {
    var result: ListPropertiesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPropertiesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
