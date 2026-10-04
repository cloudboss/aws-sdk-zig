const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationInfo = @import("application_info.zig").ApplicationInfo;

pub const UpdateApplicationInput = struct {
    /// If set to true, the managed policies for SSM and CW will be attached to the
    /// instance roles if they are missing.
    attach_missing_permission: ?bool = null,

    /// Turns auto-configuration on or off.
    auto_config_enabled: ?bool = null,

    /// Indicates whether Application Insights can listen to CloudWatch events for
    /// the
    /// application resources, such as `instance terminated`, `failed
    /// deployment`, and others.
    cwe_monitor_enabled: ?bool = null,

    /// When set to `true`, creates opsItems for any problems detected on an
    /// application.
    ops_center_enabled: ?bool = null,

    /// The SNS topic provided to Application Insights that is associated to the
    /// created
    /// opsItem. Allows you to receive notifications for updates to the opsItem.
    ops_item_sns_topic_arn: ?[]const u8 = null,

    /// Disassociates the SNS topic from the opsItem created for detected problems.
    remove_sns_topic: ?bool = null,

    /// The name of the resource group.
    resource_group_name: []const u8,

    /// The SNS topic ARN. Allows you to receive SNS notifications for updates and
    /// issues with an application.
    sns_notification_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .attach_missing_permission = "AttachMissingPermission",
        .auto_config_enabled = "AutoConfigEnabled",
        .cwe_monitor_enabled = "CWEMonitorEnabled",
        .ops_center_enabled = "OpsCenterEnabled",
        .ops_item_sns_topic_arn = "OpsItemSNSTopicArn",
        .remove_sns_topic = "RemoveSNSTopic",
        .resource_group_name = "ResourceGroupName",
        .sns_notification_arn = "SNSNotificationArn",
    };
};

pub const UpdateApplicationOutput = struct {
    /// Information about the application.
    application_info: ?ApplicationInfo = null,

    pub const json_field_names = .{
        .application_info = "ApplicationInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationInput, options: CallOptions) !UpdateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "applicationinsights", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationinsights", "Application Insights", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "EC2WindowsBarleyService.UpdateApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateApplicationOutput, body, allocator);
}
