const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuiteDefinitionConfiguration = @import("suite_definition_configuration.zig").SuiteDefinitionConfiguration;

pub const GetSuiteDefinitionInput = struct {
    /// Suite definition ID of the test suite to get.
    suite_definition_id: []const u8,

    /// Suite definition version of the test suite to get.
    suite_definition_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .suite_definition_id = "suiteDefinitionId",
        .suite_definition_version = "suiteDefinitionVersion",
    };
};

pub const GetSuiteDefinitionOutput = struct {
    /// Date (in Unix epoch time) when the suite definition was created.
    created_at: ?i64 = null,

    /// Date (in Unix epoch time) when the suite definition was last modified.
    last_modified_at: ?i64 = null,

    /// Latest suite definition version of the suite definition.
    latest_version: ?[]const u8 = null,

    /// The ARN of the suite definition.
    suite_definition_arn: ?[]const u8 = null,

    /// Suite configuration of the suite definition.
    suite_definition_configuration: ?SuiteDefinitionConfiguration = null,

    /// Suite definition ID of the suite definition.
    suite_definition_id: ?[]const u8 = null,

    /// Suite definition version of the suite definition.
    suite_definition_version: ?[]const u8 = null,

    /// Tags attached to the suite definition.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .last_modified_at = "lastModifiedAt",
        .latest_version = "latestVersion",
        .suite_definition_arn = "suiteDefinitionArn",
        .suite_definition_configuration = "suiteDefinitionConfiguration",
        .suite_definition_id = "suiteDefinitionId",
        .suite_definition_version = "suiteDefinitionVersion",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSuiteDefinitionInput, options: CallOptions) !GetSuiteDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotdeviceadvisor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSuiteDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotdeviceadvisor", "IotDeviceAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/suiteDefinitions/");
    try path_buf.appendSlice(allocator, input.suite_definition_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.suite_definition_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "suiteDefinitionVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSuiteDefinitionOutput {
    var result: GetSuiteDefinitionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSuiteDefinitionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
