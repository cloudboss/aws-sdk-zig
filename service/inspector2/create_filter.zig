const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FilterAction = @import("filter_action.zig").FilterAction;
const FilterCriteria = @import("filter_criteria.zig").FilterCriteria;

pub const CreateFilterInput = struct {
    /// Defines the action that is to be applied to the findings that match the
    /// filter.
    action: FilterAction,

    /// A description of the filter.
    description: ?[]const u8 = null,

    /// Defines the criteria to be used in the filter for querying findings.
    filter_criteria: FilterCriteria,

    /// The name of the filter. Minimum length of 3. Maximum length of 64. Valid
    /// characters
    /// include alphanumeric characters, dot (.), underscore (_), and dash (-).
    /// Spaces are not
    /// allowed.
    name: []const u8,

    /// The reason for creating the filter.
    reason: ?[]const u8 = null,

    /// A list of tags for the filter.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action = "action",
        .description = "description",
        .filter_criteria = "filterCriteria",
        .name = "name",
        .reason = "reason",
        .tags = "tags",
    };
};

pub const CreateFilterOutput = struct {
    /// The Amazon Resource Number (ARN) of the successfully created filter.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFilterInput, options: CallOptions) !CreateFilterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/filters/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"filterCriteria\":");
    try aws.json.writeValue(@TypeOf(input.filter_criteria), input.filter_criteria, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.reason) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reason\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFilterOutput {
    var result: CreateFilterOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFilterOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
