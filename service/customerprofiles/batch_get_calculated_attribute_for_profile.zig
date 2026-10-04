const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConditionOverrides = @import("condition_overrides.zig").ConditionOverrides;
const CalculatedAttributeValue = @import("calculated_attribute_value.zig").CalculatedAttributeValue;
const BatchGetCalculatedAttributeForProfileError = @import("batch_get_calculated_attribute_for_profile_error.zig").BatchGetCalculatedAttributeForProfileError;

pub const BatchGetCalculatedAttributeForProfileInput = struct {
    /// The unique name of the calculated attribute.
    calculated_attribute_name: []const u8,

    /// Overrides the condition block within the original calculated attribute
    /// definition.
    condition_overrides: ?ConditionOverrides = null,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// List of unique identifiers for customer profiles to retrieve.
    profile_ids: []const []const u8,

    pub const json_field_names = .{
        .calculated_attribute_name = "CalculatedAttributeName",
        .condition_overrides = "ConditionOverrides",
        .domain_name = "DomainName",
        .profile_ids = "ProfileIds",
    };
};

pub const BatchGetCalculatedAttributeForProfileOutput = struct {
    /// List of calculated attribute values retrieved.
    calculated_attribute_values: ?[]const CalculatedAttributeValue = null,

    /// Overrides the condition block within the original calculated attribute
    /// definition.
    condition_overrides: ?ConditionOverrides = null,

    /// List of errors for calculated attribute values that could not be retrieved.
    errors: ?[]const BatchGetCalculatedAttributeForProfileError = null,

    pub const json_field_names = .{
        .calculated_attribute_values = "CalculatedAttributeValues",
        .condition_overrides = "ConditionOverrides",
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetCalculatedAttributeForProfileInput, options: CallOptions) !BatchGetCalculatedAttributeForProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetCalculatedAttributeForProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/calculated-attributes/");
    try path_buf.appendSlice(allocator, input.calculated_attribute_name);
    try path_buf.appendSlice(allocator, "/batch-get-for-profiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.condition_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConditionOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProfileIds\":");
    try aws.json.writeValue(@TypeOf(input.profile_ids), input.profile_ids, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetCalculatedAttributeForProfileOutput {
    const result: BatchGetCalculatedAttributeForProfileOutput = try aws.json.parseJsonObject(
        BatchGetCalculatedAttributeForProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
