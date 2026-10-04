const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationDefinitionInput = @import("configuration_definition_input.zig").ConfigurationDefinitionInput;

pub const CreateConfigurationManagerInput = struct {
    /// The definition of the Quick Setup configuration that the configuration
    /// manager
    /// deploys.
    configuration_definitions: []const ConfigurationDefinitionInput,

    /// A description of the configuration manager.
    description: ?[]const u8 = null,

    /// A name for the configuration manager.
    name: ?[]const u8 = null,

    /// Key-value pairs of metadata to assign to the configuration manager.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .configuration_definitions = "ConfigurationDefinitions",
        .description = "Description",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateConfigurationManagerOutput = struct {
    /// The ARN for the newly created configuration manager.
    manager_arn: []const u8,

    pub const json_field_names = .{
        .manager_arn = "ManagerArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfigurationManagerInput, options: CallOptions) !CreateConfigurationManagerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-quicksetup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfigurationManagerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-quicksetup", "SSM QuickSetup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configurationManager";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConfigurationDefinitions\":");
    try aws.json.writeValue(@TypeOf(input.configuration_definitions), input.configuration_definitions, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfigurationManagerOutput {
    var result: CreateConfigurationManagerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConfigurationManagerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
