const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InterpolationParameters = @import("interpolation_parameters.zig").InterpolationParameters;
const OrderByTime = @import("order_by_time.zig").OrderByTime;
const PropertyFilter = @import("property_filter.zig").PropertyFilter;
const PropertyValueHistory = @import("property_value_history.zig").PropertyValueHistory;

pub const GetPropertyValueHistoryInput = struct {
    /// The name of the component.
    component_name: ?[]const u8 = null,

    /// This string specifies the path to the composite component, starting from the
    /// top-level component.
    component_path: ?[]const u8 = null,

    /// The ID of the component type.
    component_type_id: ?[]const u8 = null,

    /// The date and time of the latest property value to return.
    end_date_time: ?i64 = null,

    /// The ISO8601 DateTime of the latest property value to return.
    ///
    /// For more information about the ISO8601 DateTime format, see the data type
    /// [PropertyValue](https://docs.aws.amazon.com/iot-twinmaker/latest/apireference/API_PropertyValue.html).
    end_time: ?[]const u8 = null,

    /// The ID of the entity.
    entity_id: ?[]const u8 = null,

    /// An object that specifies the interpolation type and the interval over which
    /// to
    /// interpolate data.
    interpolation: ?InterpolationParameters = null,

    /// The maximum number of results to return at one time. The default is 25.
    ///
    /// Valid Range: Minimum value of 1. Maximum value of 250.
    max_results: ?i32 = null,

    /// The string that specifies the next page of results.
    next_token: ?[]const u8 = null,

    /// The time direction to use in the result order.
    order_by_time: ?OrderByTime = null,

    /// A list of objects that filter the property value history request.
    property_filters: ?[]const PropertyFilter = null,

    /// A list of properties whose value histories the request retrieves.
    selected_properties: []const []const u8,

    /// The date and time of the earliest property value to return.
    start_date_time: ?i64 = null,

    /// The ISO8601 DateTime of the earliest property value to return.
    ///
    /// For more information about the ISO8601 DateTime format, see the data type
    /// [PropertyValue](https://docs.aws.amazon.com/iot-twinmaker/latest/apireference/API_PropertyValue.html).
    start_time: ?[]const u8 = null,

    /// The ID of the workspace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .component_name = "componentName",
        .component_path = "componentPath",
        .component_type_id = "componentTypeId",
        .end_date_time = "endDateTime",
        .end_time = "endTime",
        .entity_id = "entityId",
        .interpolation = "interpolation",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .order_by_time = "orderByTime",
        .property_filters = "propertyFilters",
        .selected_properties = "selectedProperties",
        .start_date_time = "startDateTime",
        .start_time = "startTime",
        .workspace_id = "workspaceId",
    };
};

pub const GetPropertyValueHistoryOutput = struct {
    /// The string that specifies the next page of results.
    next_token: ?[]const u8 = null,

    /// An object that maps strings to the property definitions in the component
    /// type. Each
    /// string in the mapping must be unique to this object.
    property_values: ?[]const PropertyValueHistory = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .property_values = "propertyValues",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPropertyValueHistoryInput, options: CallOptions) !GetPropertyValueHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPropertyValueHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/entity-properties/history");
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
    if (input.end_date_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endDateTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.end_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entity_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"entityId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.interpolation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"interpolation\":");
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
    if (input.order_by_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"orderByTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.property_filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"propertyFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"selectedProperties\":");
    try aws.json.writeValue(@TypeOf(input.selected_properties), input.selected_properties, allocator, &body_buf);
    has_prev = true;
    if (input.start_date_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"startDateTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.start_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"startTime\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPropertyValueHistoryOutput {
    var result: GetPropertyValueHistoryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPropertyValueHistoryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
