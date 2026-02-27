const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: Options) !CreateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "applicationinsights");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationinsights", "Application Insights", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "EC2WindowsBarleyService.CreateApplication");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateApplicationOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagsAlreadyExistException")) {
        return .{ .arena = arena, .kind = .{ .tags_already_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
