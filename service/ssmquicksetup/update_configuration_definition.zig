const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateConfigurationDefinitionInput = struct {
    /// The ID of the configuration definition you want to update.
    id: []const u8,

    /// The ARN of the IAM role used to administrate local configuration
    /// deployments.
    local_deployment_administration_role_arn: ?[]const u8 = null,

    /// The name of the IAM role used to deploy local
    /// configurations.
    local_deployment_execution_role_name: ?[]const u8 = null,

    /// The ARN of the configuration manager associated with the definition to
    /// update.
    manager_arn: []const u8,

    /// The parameters for the configuration definition type.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The version of the Quick Setup type to use.
    type_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .local_deployment_administration_role_arn = "LocalDeploymentAdministrationRoleArn",
        .local_deployment_execution_role_name = "LocalDeploymentExecutionRoleName",
        .manager_arn = "ManagerArn",
        .parameters = "Parameters",
        .type_version = "TypeVersion",
    };
};

pub const UpdateConfigurationDefinitionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConfigurationDefinitionInput, options: CallOptions) !UpdateConfigurationDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConfigurationDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-quicksetup", "SSM QuickSetup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/configurationDefinition/");
    try path_buf.appendSlice(allocator, input.manager_arn);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.local_deployment_administration_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LocalDeploymentAdministrationRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.local_deployment_execution_role_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LocalDeploymentExecutionRoleName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.type_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TypeVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConfigurationDefinitionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateConfigurationDefinitionOutput = .{};

    return result;
}
