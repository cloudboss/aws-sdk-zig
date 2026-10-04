const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnabledBaselineParameter = @import("enabled_baseline_parameter.zig").EnabledBaselineParameter;

pub const EnableBaselineInput = struct {
    /// The ARN of the baseline to be enabled.
    baseline_identifier: []const u8,

    /// The specific version to be enabled of the specified baseline.
    baseline_version: []const u8,

    /// A list of `key-value` objects that specify enablement parameters, where
    /// `key` is a string and `value` is a document of any type.
    parameters: ?[]const EnabledBaselineParameter = null,

    /// Tags associated with input to `EnableBaseline`.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the target on which the baseline will be enabled. Only OUs are
    /// supported as targets.
    target_identifier: []const u8,

    pub const json_field_names = .{
        .baseline_identifier = "baselineIdentifier",
        .baseline_version = "baselineVersion",
        .parameters = "parameters",
        .tags = "tags",
        .target_identifier = "targetIdentifier",
    };
};

pub const EnableBaselineOutput = struct {
    /// The ARN of the `EnabledBaseline` resource.
    arn: []const u8,

    /// The ID (in UUID format) of the asynchronous `EnableBaseline` operation. This
    /// `operationIdentifier` is used to track status through calls to the
    /// `GetBaselineOperation` API.
    operation_identifier: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .operation_identifier = "operationIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableBaselineInput, options: CallOptions) !EnableBaselineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "controltower", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableBaselineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controltower", "ControlTower", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/enable-baseline";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"baselineIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.baseline_identifier), input.baseline_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"baselineVersion\":");
    try aws.json.writeValue(@TypeOf(input.baseline_version), input.baseline_version, allocator, &body_buf);
    has_prev = true;
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.target_identifier), input.target_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableBaselineOutput {
    var result: EnableBaselineOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(EnableBaselineOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
