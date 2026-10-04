const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttachmentsConfiguration = @import("attachments_configuration.zig").AttachmentsConfiguration;
const AutoSubscriptionConfiguration = @import("auto_subscription_configuration.zig").AutoSubscriptionConfiguration;
const PersonalizationConfiguration = @import("personalization_configuration.zig").PersonalizationConfiguration;
const QAppsConfiguration = @import("q_apps_configuration.zig").QAppsConfiguration;

pub const UpdateApplicationInput = struct {
    /// The identifier of the Amazon Q Business application.
    application_id: []const u8,

    /// An option to allow end users to upload files directly during chat.
    attachments_configuration: ?AttachmentsConfiguration = null,

    /// An option to enable updating the default subscription type assigned to an
    /// Amazon Q Business application using IAM identity federation for user
    /// management.
    auto_subscription_configuration: ?AutoSubscriptionConfiguration = null,

    /// A description for the Amazon Q Business application.
    description: ?[]const u8 = null,

    /// A name for the Amazon Q Business application.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center instance you are
    /// either creating for—or connecting to—your Amazon Q Business application.
    identity_center_instance_arn: ?[]const u8 = null,

    /// Configuration information about chat response personalization. For more
    /// information, see [Personalizing chat
    /// responses](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/personalizing-chat-responses.html).
    personalization_configuration: ?PersonalizationConfiguration = null,

    /// An option to allow end users to create and use Amazon Q Apps in the web
    /// experience.
    q_apps_configuration: ?QAppsConfiguration = null,

    /// An Amazon Web Services Identity and Access Management (IAM) role that gives
    /// Amazon Q Business permission to access Amazon CloudWatch logs and metrics.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .attachments_configuration = "attachmentsConfiguration",
        .auto_subscription_configuration = "autoSubscriptionConfiguration",
        .description = "description",
        .display_name = "displayName",
        .identity_center_instance_arn = "identityCenterInstanceArn",
        .personalization_configuration = "personalizationConfiguration",
        .q_apps_configuration = "qAppsConfiguration",
        .role_arn = "roleArn",
    };
};

pub const UpdateApplicationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationInput, options: CallOptions) !UpdateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attachments_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attachmentsConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_subscription_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoSubscriptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_center_instance_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"identityCenterInstanceArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.personalization_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"personalizationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.q_apps_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"qAppsConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateApplicationOutput = .{};

    return result;
}
