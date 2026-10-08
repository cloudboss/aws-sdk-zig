const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MobileDeviceAccessRuleEffect = @import("mobile_device_access_rule_effect.zig").MobileDeviceAccessRuleEffect;

pub const UpdateMobileDeviceAccessRuleInput = struct {
    /// The updated rule description.
    description: ?[]const u8 = null,

    /// Device models that the updated rule will match.
    device_models: ?[]const []const u8 = null,

    /// Device operating systems that the updated rule will match.
    device_operating_systems: ?[]const []const u8 = null,

    /// Device types that the updated rule will match.
    device_types: ?[]const []const u8 = null,

    /// User agents that the updated rule will match.
    device_user_agents: ?[]const []const u8 = null,

    /// The effect of the rule when it matches. Allowed values are `ALLOW` or
    /// `DENY`.
    effect: MobileDeviceAccessRuleEffect,

    /// The identifier of the rule to be updated.
    mobile_device_access_rule_id: []const u8,

    /// The updated rule name.
    name: []const u8,

    /// Device models that the updated rule **will not** match. All other device
    /// models will match.
    not_device_models: ?[]const []const u8 = null,

    /// Device operating systems that the updated rule **will not** match. All other
    /// device operating systems will match.
    not_device_operating_systems: ?[]const []const u8 = null,

    /// Device types that the updated rule **will not** match. All other device
    /// types will match.
    not_device_types: ?[]const []const u8 = null,

    /// User agents that the updated rule **will not** match. All other user agents
    /// will match.
    not_device_user_agents: ?[]const []const u8 = null,

    /// The WorkMail organization under which the rule will be updated.
    organization_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .device_models = "DeviceModels",
        .device_operating_systems = "DeviceOperatingSystems",
        .device_types = "DeviceTypes",
        .device_user_agents = "DeviceUserAgents",
        .effect = "Effect",
        .mobile_device_access_rule_id = "MobileDeviceAccessRuleId",
        .name = "Name",
        .not_device_models = "NotDeviceModels",
        .not_device_operating_systems = "NotDeviceOperatingSystems",
        .not_device_types = "NotDeviceTypes",
        .not_device_user_agents = "NotDeviceUserAgents",
        .organization_id = "OrganizationId",
    };
};

pub const UpdateMobileDeviceAccessRuleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMobileDeviceAccessRuleInput, options: CallOptions) !UpdateMobileDeviceAccessRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMobileDeviceAccessRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.UpdateMobileDeviceAccessRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMobileDeviceAccessRuleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
