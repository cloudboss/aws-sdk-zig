const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MobileDeviceAccessRuleEffect = @import("mobile_device_access_rule_effect.zig").MobileDeviceAccessRuleEffect;

pub const GetMobileDeviceAccessOverrideInput = struct {
    /// The mobile device to which the override applies. `DeviceId` is case
    /// insensitive.
    device_id: []const u8,

    /// The WorkMail organization to which you want to apply the override.
    organization_id: []const u8,

    /// Identifies the WorkMail user for the override. Accepts the following types
    /// of user identities:
    ///
    /// * User ID: `12345678-1234-1234-1234-123456789012` or
    ///   `S-1-1-12-1234567890-123456789-123456789-1234`
    ///
    /// * Email address: `user@domain.tld`
    ///
    /// * User name: `user`
    user_id: []const u8,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .organization_id = "OrganizationId",
        .user_id = "UserId",
    };
};

pub const GetMobileDeviceAccessOverrideOutput = struct {
    /// The date the override was first created.
    date_created: ?i64 = null,

    /// The date the description was last modified.
    date_modified: ?i64 = null,

    /// A description of the override.
    description: ?[]const u8 = null,

    /// The device to which the access override applies.
    device_id: ?[]const u8 = null,

    /// The effect of the override, `ALLOW` or `DENY`.
    effect: ?MobileDeviceAccessRuleEffect = null,

    /// The WorkMail user to which the access override applies.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .date_created = "DateCreated",
        .date_modified = "DateModified",
        .description = "Description",
        .device_id = "DeviceId",
        .effect = "Effect",
        .user_id = "UserId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMobileDeviceAccessOverrideInput, options: CallOptions) !GetMobileDeviceAccessOverrideOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMobileDeviceAccessOverrideInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.GetMobileDeviceAccessOverride");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMobileDeviceAccessOverrideOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMobileDeviceAccessOverrideOutput, body, allocator);
}
