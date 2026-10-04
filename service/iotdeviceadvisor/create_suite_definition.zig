const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuiteDefinitionConfiguration = @import("suite_definition_configuration.zig").SuiteDefinitionConfiguration;

pub const CreateSuiteDefinitionInput = struct {
    /// The client token for the test suite definition creation.
    /// This token is used for tracking test suite definition creation
    /// using retries and obtaining its status. This parameter is optional.
    client_token: ?[]const u8 = null,

    /// Creates a Device Advisor test suite with suite definition configuration.
    suite_definition_configuration: SuiteDefinitionConfiguration,

    /// The tags to be attached to the suite definition.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .suite_definition_configuration = "suiteDefinitionConfiguration",
        .tags = "tags",
    };
};

pub const CreateSuiteDefinitionOutput = struct {
    /// The timestamp of when the test suite was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the test suite.
    suite_definition_arn: ?[]const u8 = null,

    /// The UUID of the test suite created.
    suite_definition_id: ?[]const u8 = null,

    /// The suite definition name of the test suite. This is a required parameter.
    suite_definition_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .suite_definition_arn = "suiteDefinitionArn",
        .suite_definition_id = "suiteDefinitionId",
        .suite_definition_name = "suiteDefinitionName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSuiteDefinitionInput, options: CallOptions) !CreateSuiteDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSuiteDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotdeviceadvisor", "IotDeviceAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/suiteDefinitions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"suiteDefinitionConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.suite_definition_configuration), input.suite_definition_configuration, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSuiteDefinitionOutput {
    const result: CreateSuiteDefinitionOutput = try aws.json.parseJsonObject(
        CreateSuiteDefinitionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
