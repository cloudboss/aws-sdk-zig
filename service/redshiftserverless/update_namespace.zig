const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogDestinationType = @import("log_destination_type.zig").LogDestinationType;
const LogExport = @import("log_export.zig").LogExport;
const S3TableAction = @import("s3_table_action.zig").S3TableAction;
const S3TableGranularity = @import("s3_table_granularity.zig").S3TableGranularity;
const Namespace = @import("namespace.zig").Namespace;

pub const UpdateNamespaceInput = struct {
    /// The ID of the Key Management Service (KMS) key used to encrypt and store the
    /// namespace's admin credentials secret. You can only use this parameter if
    /// `manageAdminPassword` is true.
    admin_password_secret_kms_key_id: ?[]const u8 = null,

    /// The username of the administrator for the first database created in the
    /// namespace. This parameter must be updated together with `adminUserPassword`.
    admin_username: ?[]const u8 = null,

    /// The password of the administrator for the first database created in the
    /// namespace. This parameter must be updated together with `adminUsername`.
    ///
    /// You can't use `adminUserPassword` if `manageAdminPassword` is true.
    ///
    /// If your admin user account is locked, this operation also unlocks your
    /// account and resets the failed-login counter. This option is available only
    /// when account lockout security is enabled for the namespace.
    admin_user_password: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role to set as a default in the
    /// namespace. This parameter must be updated together with `iamRoles`.
    default_iam_role_arn: ?[]const u8 = null,

    /// A list of IAM roles to associate with the namespace. This parameter must be
    /// updated together with `defaultIamRoleArn`.
    iam_roles: ?[]const []const u8 = null,

    /// The ID of the Amazon Web Services Key Management Service key used to encrypt
    /// your data.
    kms_key_id: ?[]const u8 = null,

    /// The destination for the log data. Valid values are `s3table` and
    /// `cloudwatch`.
    ///
    /// Set this to `s3table` to manage Amazon S3 Tables system-table publishing for
    /// the namespace.
    log_destination_type: ?LogDestinationType = null,

    /// The types of logs the namespace can export. The export types are `userlog`,
    /// `connectionlog`, and `useractivitylog`.
    log_exports: ?[]const LogExport = null,

    /// If `true`, Amazon Redshift uses Secrets Manager to manage the namespace's
    /// admin credentials. You can't use `adminUserPassword` if
    /// `manageAdminPassword` is true. If `manageAdminPassword` is false or not set,
    /// Amazon Redshift uses `adminUserPassword` for the admin user account's
    /// password.
    manage_admin_password: ?bool = null,

    /// The name of the namespace to update. You can't update the name of a
    /// namespace once it is created.
    namespace_name: []const u8,

    /// Whether to enable or disable Amazon S3 Tables publishing. Valid values are
    /// `Enable` and `Disable`, matched case-insensitively.
    ///
    /// When omitted, defaults to `Enable`. Valid only when `logDestinationType` is
    /// `s3table`.
    s_3_table_action: ?S3TableAction = null,

    /// The scope of the Amazon S3 Tables destination. Valid values are `namespace`
    /// and `account`, matched case-insensitively. `namespace` scopes the published
    /// tables to this namespace; `account` scopes them to the Amazon Web Services
    /// account.
    ///
    /// Required when enabling. Omitting this parameter or passing a blank value
    /// fails with `ValidationException`. Valid only when `logDestinationType` is
    /// `s3table`.
    s_3_table_granularity: ?S3TableGranularity = null,

    /// The identifier of the Key Management Service key used to encrypt the
    /// published Amazon S3 Tables data. When omitted, the data is encrypted with
    /// SSE-S3 (Amazon S3 managed keys).
    ///
    /// Valid only when `logDestinationType` is `s3table`.
    s_3_table_kms_key_id: ?[]const u8 = null,

    /// The system tables to publish (on enable) or to stop publishing (on disable).
    /// Each value is either a system table view name that begins with `sys_` or the
    /// keyword `all`.
    ///
    /// Omitting this parameter, passing an empty list, or including `all` each
    /// select every current and future system table. Each name must be 1-128
    /// characters, and the list can contain up to 256 names.
    ///
    /// Valid only when `logDestinationType` is `s3table`.
    s_3_table_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .admin_password_secret_kms_key_id = "adminPasswordSecretKmsKeyId",
        .admin_username = "adminUsername",
        .admin_user_password = "adminUserPassword",
        .default_iam_role_arn = "defaultIamRoleArn",
        .iam_roles = "iamRoles",
        .kms_key_id = "kmsKeyId",
        .log_destination_type = "logDestinationType",
        .log_exports = "logExports",
        .manage_admin_password = "manageAdminPassword",
        .namespace_name = "namespaceName",
        .s_3_table_action = "s3TableAction",
        .s_3_table_granularity = "s3TableGranularity",
        .s_3_table_kms_key_id = "s3TableKmsKeyId",
        .s_3_table_names = "s3TableNames",
    };
};

pub const UpdateNamespaceOutput = struct {
    /// A list of tag instances.
    namespace: ?Namespace = null,

    pub const json_field_names = .{
        .namespace = "namespace",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNamespaceInput, options: CallOptions) !UpdateNamespaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.UpdateNamespace");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNamespaceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateNamespaceOutput, body, allocator);
}
