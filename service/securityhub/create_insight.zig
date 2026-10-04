const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AwsSecurityFindingFilters = @import("aws_security_finding_filters.zig").AwsSecurityFindingFilters;

pub const CreateInsightInput = struct {
    /// One or more attributes used to filter the findings included in the insight.
    /// The insight
    /// only includes findings that match the criteria defined in the filters.
    filters: AwsSecurityFindingFilters,

    /// The attribute used to group the findings for the insight. The grouping
    /// attribute
    /// identifies the type of item that the insight applies to. For example, if an
    /// insight is
    /// grouped by resource identifier, then the insight produces a list of resource
    /// identifiers.
    group_by_attribute: []const u8,

    /// The name of the custom insight to create.
    name: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .group_by_attribute = "GroupByAttribute",
        .name = "Name",
    };
};

pub const CreateInsightOutput = struct {
    /// The ARN of the insight created.
    insight_arn: []const u8,

    pub const json_field_names = .{
        .insight_arn = "InsightArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInsightInput, options: CallOptions) !CreateInsightOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInsightInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/insights";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Filters\":");
    try aws.json.writeValue(@TypeOf(input.filters), input.filters, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GroupByAttribute\":");
    try aws.json.writeValue(@TypeOf(input.group_by_attribute), input.group_by_attribute, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInsightOutput {
    const result: CreateInsightOutput = try aws.json.parseJsonObject(
        CreateInsightOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
