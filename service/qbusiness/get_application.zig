const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppliedAttachmentsConfiguration = @import("applied_attachments_configuration.zig").AppliedAttachmentsConfiguration;
const AutoSubscriptionConfiguration = @import("auto_subscription_configuration.zig").AutoSubscriptionConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const IdentityType = @import("identity_type.zig").IdentityType;
const PersonalizationConfiguration = @import("personalization_configuration.zig").PersonalizationConfiguration;
const QAppsConfiguration = @import("q_apps_configuration.zig").QAppsConfiguration;
const QuickSightConfiguration = @import("quick_sight_configuration.zig").QuickSightConfiguration;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

pub const GetApplicationInput = struct {
    /// The identifier of the Amazon Q Business application.
    application_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
    };
};

pub const GetApplicationOutput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Q Business application.
    application_arn: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business application.
    application_id: ?[]const u8 = null,

    /// Settings for whether end users can upload files directly during chat.
    attachments_configuration: ?AppliedAttachmentsConfiguration = null,

    /// Settings for auto-subscription behavior for this application. This is only
    /// applicable to SAML and OIDC applications.
    auto_subscription_configuration: ?AutoSubscriptionConfiguration = null,

    /// The OIDC client ID for a Amazon Q Business application.
    client_ids_for_oidc: ?[]const []const u8 = null,

    /// The Unix timestamp when the Amazon Q Business application was last updated.
    created_at: ?i64 = null,

    /// A description for the Amazon Q Business application.
    description: ?[]const u8 = null,

    /// The name of the Amazon Q Business application.
    display_name: ?[]const u8 = null,

    /// The identifier of the Amazon Web Services KMS key that is used to encrypt
    /// your data. Amazon Q Business doesn't support asymmetric keys.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// If the `Status` field is set to `ERROR`, the `ErrorMessage` field contains a
    /// description of the error that caused the synchronization to fail.
    @"error": ?ErrorDetail = null,

    /// The Amazon Resource Name (ARN) of an identity provider being used by an
    /// Amazon Q Business application.
    iam_identity_provider_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the AWS IAM Identity Center instance
    /// attached to your Amazon Q Business application.
    identity_center_application_arn: ?[]const u8 = null,

    /// The authentication type being used by a Amazon Q Business application.
    identity_type: ?IdentityType = null,

    /// Configuration information about chat response personalization. For more
    /// information, see [Personalizing chat
    /// responses](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/personalizing-chat-responses.html).
    personalization_configuration: ?PersonalizationConfiguration = null,

    /// Settings for whether end users can create and use Amazon Q Apps in the web
    /// experience.
    q_apps_configuration: ?QAppsConfiguration = null,

    /// The Amazon Quick Suite authentication configuration for the Amazon Q
    /// Business application.
    quick_sight_configuration: ?QuickSightConfiguration = null,

    /// The Amazon Resource Name (ARN) of the IAM with permissions to access your
    /// CloudWatch logs and metrics.
    role_arn: ?[]const u8 = null,

    /// The status of the Amazon Q Business application.
    status: ?ApplicationStatus = null,

    /// The Unix timestamp when the Amazon Q Business application was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .application_id = "applicationId",
        .attachments_configuration = "attachmentsConfiguration",
        .auto_subscription_configuration = "autoSubscriptionConfiguration",
        .client_ids_for_oidc = "clientIdsForOIDC",
        .created_at = "createdAt",
        .description = "description",
        .display_name = "displayName",
        .encryption_configuration = "encryptionConfiguration",
        .@"error" = "error",
        .iam_identity_provider_arn = "iamIdentityProviderArn",
        .identity_center_application_arn = "identityCenterApplicationArn",
        .identity_type = "identityType",
        .personalization_configuration = "personalizationConfiguration",
        .q_apps_configuration = "qAppsConfiguration",
        .quick_sight_configuration = "quickSightConfiguration",
        .role_arn = "roleArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationInput, options: CallOptions) !GetApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationOutput {
    const result: GetApplicationOutput = try aws.json.parseJsonObject(
        GetApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
