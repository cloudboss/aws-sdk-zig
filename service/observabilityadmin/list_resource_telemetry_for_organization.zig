const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;
const TelemetryState = @import("telemetry_state.zig").TelemetryState;
const TelemetryConfiguration = @import("telemetry_configuration.zig").TelemetryConfiguration;

pub const ListResourceTelemetryForOrganizationInput = struct {
    /// A list of Amazon Web Services accounts used to filter the resources to those
    /// associated with the specified accounts.
    account_identifiers: ?[]const []const u8 = null,

    /// A number field used to limit the number of results within the returned list.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. A previous call provides this
    /// token.
    next_token: ?[]const u8 = null,

    /// A string used to filter resources in the organization which have a
    /// `ResourceIdentifier` starting with the `ResourceIdentifierPrefix`.
    resource_identifier_prefix: ?[]const u8 = null,

    /// A key-value pair to filter resources in the organization based on tags
    /// associated with the resource. Fore more information about tags, see [What
    /// are
    /// tags?](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/what-are-tags.html)
    resource_tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of resource types used to filter resources in the organization. If
    /// this parameter is provided, the resources will be returned in the same order
    /// used in the request.
    resource_types: ?[]const ResourceType = null,

    /// A key-value pair to filter resources in the organization based on the
    /// telemetry type and the state of the telemetry configuration. The key is the
    /// telemetry type and the value is the state.
    telemetry_configuration_state: ?[]const aws.map.MapEntry(TelemetryState) = null,

    pub const json_field_names = .{
        .account_identifiers = "AccountIdentifiers",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_identifier_prefix = "ResourceIdentifierPrefix",
        .resource_tags = "ResourceTags",
        .resource_types = "ResourceTypes",
        .telemetry_configuration_state = "TelemetryConfigurationState",
    };
};

pub const ListResourceTelemetryForOrganizationOutput = struct {
    /// The token for the next set of items to return. A previous call provides this
    /// token.
    next_token: ?[]const u8 = null,

    /// A list of telemetry configurations for Amazon Web Services resources
    /// supported by telemetry config in the organization.
    telemetry_configurations: ?[]const TelemetryConfiguration = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .telemetry_configurations = "TelemetryConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceTelemetryForOrganizationInput, options: CallOptions) !ListResourceTelemetryForOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "observabilityadmin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceTelemetryForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListResourceTelemetryForOrganization";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_identifiers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountIdentifiers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_identifier_prefix) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceIdentifierPrefix\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.telemetry_configuration_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TelemetryConfigurationState\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceTelemetryForOrganizationOutput {
    var result: ListResourceTelemetryForOrganizationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListResourceTelemetryForOrganizationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
