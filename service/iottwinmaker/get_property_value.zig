const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TabularConditions = @import("tabular_conditions.zig").TabularConditions;
const PropertyLatestValue = @import("property_latest_value.zig").PropertyLatestValue;
const DataValue = @import("data_value.zig").DataValue;

pub const GetPropertyValueInput = struct {
    /// The name of the component whose property values the operation returns.
    component_name: ?[]const u8 = null,

    /// This string specifies the path to the composite component, starting from the
    /// top-level component.
    component_path: ?[]const u8 = null,

    /// The ID of the component type whose property values the operation returns.
    component_type_id: ?[]const u8 = null,

    /// The ID of the entity whose property values the operation returns.
    entity_id: ?[]const u8 = null,

    /// The maximum number of results to return at one time. The default is 25.
    ///
    /// Valid Range: Minimum value of 1. Maximum value of 250.
    max_results: ?i32 = null,

    /// The string that specifies the next page of results.
    next_token: ?[]const u8 = null,

    /// The property group name.
    property_group_name: ?[]const u8 = null,

    /// The properties whose values the operation returns.
    selected_properties: []const []const u8,

    /// The tabular conditions.
    tabular_conditions: ?TabularConditions = null,

    /// The ID of the workspace whose values the operation returns.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .component_name = "componentName",
        .component_path = "componentPath",
        .component_type_id = "componentTypeId",
        .entity_id = "entityId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .property_group_name = "propertyGroupName",
        .selected_properties = "selectedProperties",
        .tabular_conditions = "tabularConditions",
        .workspace_id = "workspaceId",
    };
};

pub const GetPropertyValueOutput = struct {
    /// The string that specifies the next page of results.
    next_token: ?[]const u8 = null,

    /// An object that maps strings to the properties and latest property values in
    /// the
    /// response. Each string in the mapping must be unique to this object.
    property_values: ?[]const aws.map.MapEntry(PropertyLatestValue) = null,

    /// A table of property values.
    tabular_property_values: ?[]const []const []const aws.map.MapEntry(DataValue) = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .property_values = "propertyValues",
        .tabular_property_values = "tabularPropertyValues",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPropertyValueInput, options: CallOptions) !GetPropertyValueOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPropertyValueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/entity-properties/value");
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
    if (input.component_type_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"componentTypeId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entity_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"entityId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.property_group_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"propertyGroupName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"selectedProperties\":");
    try aws.json.writeValue(@TypeOf(input.selected_properties), input.selected_properties, allocator, &body_buf);
    has_prev = true;
    if (input.tabular_conditions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tabularConditions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPropertyValueOutput {
    const result: GetPropertyValueOutput = try aws.json.parseJsonObject(
        GetPropertyValueOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
