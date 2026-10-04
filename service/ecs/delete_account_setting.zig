const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SettingName = @import("setting_name.zig").SettingName;
const Setting = @import("setting.zig").Setting;

pub const DeleteAccountSettingInput = struct {
    /// The resource name to disable the account setting for. If
    /// `serviceLongArnFormat` is specified, the ARN for your Amazon ECS services is
    /// affected. If `taskLongArnFormat` is specified, the ARN and resource ID for
    /// your Amazon ECS tasks is affected. If `containerInstanceLongArnFormat` is
    /// specified, the ARN and resource ID for your Amazon ECS container instances
    /// is affected. If `awsvpcTrunking` is specified, the ENI limit for your Amazon
    /// ECS container instances is affected.
    name: SettingName,

    /// The Amazon Resource Name (ARN) of the principal. It can be a user, role, or
    /// the root user. If you specify the root user, it disables the account setting
    /// for all users, roles, and the root user of the account unless a user or role
    /// explicitly overrides these settings. If this field is omitted, the setting
    /// is changed only for the authenticated user.
    ///
    /// In order to use this parameter, you must be the root user, or the principal.
    principal_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .principal_arn = "principalArn",
    };
};

pub const DeleteAccountSettingOutput = struct {
    /// The account setting for the specified principal ARN.
    setting: ?Setting = null,

    pub const json_field_names = .{
        .setting = "setting",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAccountSettingInput, options: CallOptions) !DeleteAccountSettingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAccountSettingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DeleteAccountSetting");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAccountSettingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteAccountSettingOutput, body, allocator);
}
