const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MobileDeviceAccessRuleEffect = @import("mobile_device_access_rule_effect.zig").MobileDeviceAccessRuleEffect;

pub const CreateMobileDeviceAccessRuleInput = struct {
    /// The idempotency token for the client request.
    client_token: ?[]const u8 = null,

    /// The rule description.
    description: ?[]const u8 = null,

    /// Device models that the rule will match.
    device_models: ?[]const []const u8 = null,

    /// Device operating systems that the rule will match.
    device_operating_systems: ?[]const []const u8 = null,

    /// Device types that the rule will match.
    device_types: ?[]const []const u8 = null,

    /// Device user agents that the rule will match.
    device_user_agents: ?[]const []const u8 = null,

    /// The effect of the rule when it matches. Allowed values are `ALLOW` or
    /// `DENY`.
    effect: MobileDeviceAccessRuleEffect,

    /// The rule name.
    name: []const u8,

    /// Device models that the rule **will not** match. All other device models will
    /// match.
    not_device_models: ?[]const []const u8 = null,

    /// Device operating systems that the rule **will not** match. All other device
    /// operating systems will match.
    not_device_operating_systems: ?[]const []const u8 = null,

    /// Device types that the rule **will not** match. All other device types will
    /// match.
    not_device_types: ?[]const []const u8 = null,

    /// Device user agents that the rule **will not** match. All other device user
    /// agents will match.
    not_device_user_agents: ?[]const []const u8 = null,

    /// The WorkMail organization under which the rule will be created.
    organization_id: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .device_models = "DeviceModels",
        .device_operating_systems = "DeviceOperatingSystems",
        .device_types = "DeviceTypes",
        .device_user_agents = "DeviceUserAgents",
        .effect = "Effect",
        .name = "Name",
        .not_device_models = "NotDeviceModels",
        .not_device_operating_systems = "NotDeviceOperatingSystems",
        .not_device_types = "NotDeviceTypes",
        .not_device_user_agents = "NotDeviceUserAgents",
        .organization_id = "OrganizationId",
    };
};

pub const CreateMobileDeviceAccessRuleOutput = struct {
    /// The identifier for the newly created mobile device access rule.
    mobile_device_access_rule_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .mobile_device_access_rule_id = "MobileDeviceAccessRuleId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMobileDeviceAccessRuleInput, options: CallOptions) !CreateMobileDeviceAccessRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMobileDeviceAccessRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.CreateMobileDeviceAccessRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMobileDeviceAccessRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMobileDeviceAccessRuleOutput, body, allocator);
}
