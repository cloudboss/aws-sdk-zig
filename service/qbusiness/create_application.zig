const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttachmentsConfiguration = @import("attachments_configuration.zig").AttachmentsConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const IdentityType = @import("identity_type.zig").IdentityType;
const PersonalizationConfiguration = @import("personalization_configuration.zig").PersonalizationConfiguration;
const QAppsConfiguration = @import("q_apps_configuration.zig").QAppsConfiguration;
const QuickSightConfiguration = @import("quick_sight_configuration.zig").QuickSightConfiguration;
const Tag = @import("tag.zig").Tag;

pub const CreateApplicationInput = struct {
    /// An option to allow end users to upload files directly during chat.
    attachments_configuration: ?AttachmentsConfiguration = null,

    /// The OIDC client ID for a Amazon Q Business application.
    client_ids_for_oidc: ?[]const []const u8 = null,

    /// A token that you provide to identify the request to create your Amazon Q
    /// Business application.
    client_token: ?[]const u8 = null,

    /// A description for the Amazon Q Business application.
    description: ?[]const u8 = null,

    /// A name for the Amazon Q Business application.
    display_name: []const u8,

    /// The identifier of the KMS key that is used to encrypt your data. Amazon Q
    /// Business doesn't support asymmetric keys.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The Amazon Resource Name (ARN) of an identity provider being used by an
    /// Amazon Q Business application.
    iam_identity_provider_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center instance you are
    /// either creating for—or connecting to—your Amazon Q Business application.
    identity_center_instance_arn: ?[]const u8 = null,

    /// The authentication type being used by a Amazon Q Business application.
    identity_type: ?IdentityType = null,

    /// Configuration information about chat response personalization. For more
    /// information, see [Personalizing chat
    /// responses](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/personalizing-chat-responses.html)
    personalization_configuration: ?PersonalizationConfiguration = null,

    /// An option to allow end users to create and use Amazon Q Apps in the web
    /// experience.
    q_apps_configuration: ?QAppsConfiguration = null,

    /// The Amazon Quick Suite configuration for an Amazon Q Business application
    /// that uses Quick Suite for authentication. This configuration is required if
    /// your application uses Quick Suite as the identity provider. For more
    /// information, see [Creating an Amazon Quick Suite integrated
    /// application](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/create-quicksight-integrated-application.html).
    quick_sight_configuration: ?QuickSightConfiguration = null,

    /// The Amazon Resource Name (ARN) of an IAM role with permissions to access
    /// your Amazon CloudWatch logs and metrics. If this property is not specified,
    /// Amazon Q Business will create a [service linked role
    /// (SLR)](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/using-service-linked-roles.html#slr-permissions) and use it as the application's role.
    role_arn: ?[]const u8 = null,

    /// A list of key-value pairs that identify or categorize your Amazon Q Business
    /// application. You can also use tags to help control access to the
    /// application. Tag keys and values can consist of Unicode letters, digits,
    /// white space, and any of the following symbols: _ . : / = + - @.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .attachments_configuration = "attachmentsConfiguration",
        .client_ids_for_oidc = "clientIdsForOIDC",
        .client_token = "clientToken",
        .description = "description",
        .display_name = "displayName",
        .encryption_configuration = "encryptionConfiguration",
        .iam_identity_provider_arn = "iamIdentityProviderArn",
        .identity_center_instance_arn = "identityCenterInstanceArn",
        .identity_type = "identityType",
        .personalization_configuration = "personalizationConfiguration",
        .q_apps_configuration = "qAppsConfiguration",
        .quick_sight_configuration = "quickSightConfiguration",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreateApplicationOutput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Q Business application.
    application_arn: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business application.
    application_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .application_id = "applicationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: CallOptions) !CreateApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/applications";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attachments_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attachmentsConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_ids_for_oidc) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientIdsForOIDC\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"displayName\":");
    try aws.json.writeValue(@TypeOf(input.display_name), input.display_name, allocator, &body_buf);
    has_prev = true;
    if (input.encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.iam_identity_provider_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"iamIdentityProviderArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_center_instance_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"identityCenterInstanceArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"identityType\":");
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
    if (input.quick_sight_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"quickSightConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationOutput {
    var result: CreateApplicationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateApplicationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
