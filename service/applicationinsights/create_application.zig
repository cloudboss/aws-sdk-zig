const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupingType = @import("grouping_type.zig").GroupingType;
const Tag = @import("tag.zig").Tag;
const ApplicationInfo = @import("application_info.zig").ApplicationInfo;

pub const CreateApplicationInput = struct {
    /// If set to true, the managed policies for SSM and CW will be attached to the
    /// instance roles if they are missing.
    attach_missing_permission: ?bool = null,

    /// Indicates whether Application Insights automatically configures unmonitored
    /// resources
    /// in the resource group.
    auto_config_enabled: ?bool = null,

    /// Configures all of the resources in the resource group by applying the
    /// recommended
    /// configurations.
    auto_create: ?bool = null,

    /// Indicates whether Application Insights can listen to CloudWatch events for
    /// the
    /// application resources, such as `instance terminated`, `failed
    /// deployment`, and others.
    cwe_monitor_enabled: ?bool = null,

    /// Application Insights can create applications based on a resource group or on
    /// an account.
    /// To create an account-based application using all of the resources in the
    /// account, set this
    /// parameter to `ACCOUNT_BASED`.
    grouping_type: ?GroupingType = null,

    /// When set to `true`, creates opsItems for any problems detected on an
    /// application.
    ops_center_enabled: ?bool = null,

    /// The SNS topic provided to Application Insights that is associated to the
    /// created
    /// opsItem. Allows you to receive notifications for updates to the opsItem.
    ops_item_sns_topic_arn: ?[]const u8 = null,

    /// The name of the resource group.
    resource_group_name: ?[]const u8 = null,

    /// The SNS notification topic ARN.
    sns_notification_arn: ?[]const u8 = null,

    /// List of tags to add to the application. tag key (`Key`) and an associated
    /// tag
    /// value (`Value`). The maximum length of a tag key is 128 characters. The
    /// maximum
    /// length of a tag value is 256 characters.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .attach_missing_permission = "AttachMissingPermission",
        .auto_config_enabled = "AutoConfigEnabled",
        .auto_create = "AutoCreate",
        .cwe_monitor_enabled = "CWEMonitorEnabled",
        .grouping_type = "GroupingType",
        .ops_center_enabled = "OpsCenterEnabled",
        .ops_item_sns_topic_arn = "OpsItemSNSTopicArn",
        .resource_group_name = "ResourceGroupName",
        .sns_notification_arn = "SNSNotificationArn",
        .tags = "Tags",
    };
};

pub const CreateApplicationOutput = struct {
    /// Information about the application.
    application_info: ?ApplicationInfo = null,

    pub const json_field_names = .{
        .application_info = "ApplicationInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: CallOptions) !CreateApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "EC2WindowsBarleyService.CreateApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateApplicationOutput, body, allocator);
}
