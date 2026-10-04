const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeDetails = @import("attribute_details.zig").AttributeDetails;
const Conditions = @import("conditions.zig").Conditions;
const Filter = @import("filter.zig").Filter;
const Statistic = @import("statistic.zig").Statistic;
const Readiness = @import("readiness.zig").Readiness;
const ReadinessStatus = @import("readiness_status.zig").ReadinessStatus;

pub const CreateCalculatedAttributeDefinitionInput = struct {
    /// Mathematical expression and a list of attribute items specified in that
    /// expression.
    attribute_details: AttributeDetails,

    /// The unique name of the calculated attribute.
    calculated_attribute_name: []const u8,

    /// The conditions including range, object count, and threshold for the
    /// calculated
    /// attribute.
    conditions: ?Conditions = null,

    /// The description of the calculated attribute.
    description: ?[]const u8 = null,

    /// The display name of the calculated attribute.
    display_name: ?[]const u8 = null,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// Defines how to filter incoming objects to include part of the Calculated
    /// Attribute.
    filter: ?Filter = null,

    /// The aggregation operation to perform for the calculated attribute.
    statistic: Statistic,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Whether historical data ingested before the Calculated Attribute was created
    /// should be
    /// included in calculations.
    use_historical_data: ?bool = null,

    pub const json_field_names = .{
        .attribute_details = "AttributeDetails",
        .calculated_attribute_name = "CalculatedAttributeName",
        .conditions = "Conditions",
        .description = "Description",
        .display_name = "DisplayName",
        .domain_name = "DomainName",
        .filter = "Filter",
        .statistic = "Statistic",
        .tags = "Tags",
        .use_historical_data = "UseHistoricalData",
    };
};

pub const CreateCalculatedAttributeDefinitionOutput = struct {
    /// Mathematical expression and a list of attribute items specified in that
    /// expression.
    attribute_details: ?AttributeDetails = null,

    /// The unique name of the calculated attribute.
    calculated_attribute_name: ?[]const u8 = null,

    /// The conditions including range, object count, and threshold for the
    /// calculated
    /// attribute.
    conditions: ?Conditions = null,

    /// The timestamp of when the calculated attribute definition was created.
    created_at: ?i64 = null,

    /// The description of the calculated attribute.
    description: ?[]const u8 = null,

    /// The display name of the calculated attribute.
    display_name: ?[]const u8 = null,

    /// The filter that was used as part of the request.
    filter: ?Filter = null,

    /// The timestamp of when the calculated attribute definition was most recently
    /// edited.
    last_updated_at: ?i64 = null,

    /// Information indicating if the Calculated Attribute is ready for use by
    /// confirming all
    /// historical data has been processed and reflected.
    readiness: ?Readiness = null,

    /// The aggregation operation to perform for the calculated attribute.
    statistic: ?Statistic = null,

    /// Status of the Calculated Attribute creation (whether all historical data has
    /// been
    /// indexed.)
    status: ?ReadinessStatus = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Whether historical data ingested before the Calculated Attribute was created
    /// should be
    /// included in calculations.
    use_historical_data: ?bool = null,

    pub const json_field_names = .{
        .attribute_details = "AttributeDetails",
        .calculated_attribute_name = "CalculatedAttributeName",
        .conditions = "Conditions",
        .created_at = "CreatedAt",
        .description = "Description",
        .display_name = "DisplayName",
        .filter = "Filter",
        .last_updated_at = "LastUpdatedAt",
        .readiness = "Readiness",
        .statistic = "Statistic",
        .status = "Status",
        .tags = "Tags",
        .use_historical_data = "UseHistoricalData",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCalculatedAttributeDefinitionInput, options: CallOptions) !CreateCalculatedAttributeDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCalculatedAttributeDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/calculated-attributes/");
    try path_buf.appendSlice(allocator, input.calculated_attribute_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AttributeDetails\":");
    try aws.json.writeValue(@TypeOf(input.attribute_details), input.attribute_details, allocator, &body_buf);
    has_prev = true;
    if (input.conditions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Conditions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisplayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Statistic\":");
    try aws.json.writeValue(@TypeOf(input.statistic), input.statistic, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.use_historical_data) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UseHistoricalData\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCalculatedAttributeDefinitionOutput {
    const result: CreateCalculatedAttributeDefinitionOutput = try aws.json.parseJsonObject(
        CreateCalculatedAttributeDefinitionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
