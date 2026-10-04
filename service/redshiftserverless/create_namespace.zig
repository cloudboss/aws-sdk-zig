const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogExport = @import("log_export.zig").LogExport;
const Tag = @import("tag.zig").Tag;
const Namespace = @import("namespace.zig").Namespace;

pub const CreateNamespaceInput = struct {
    /// The ID of the Key Management Service (KMS) key used to encrypt and store the
    /// namespace's admin credentials secret. You can only use this parameter if
    /// `manageAdminPassword` is true.
    admin_password_secret_kms_key_id: ?[]const u8 = null,

    /// The username of the administrator for the first database created in the
    /// namespace.
    admin_username: ?[]const u8 = null,

    /// The password of the administrator for the first database created in the
    /// namespace.
    ///
    /// You can't use `adminUserPassword` if `manageAdminPassword` is true.
    admin_user_password: ?[]const u8 = null,

    /// The name of the first database created in the namespace.
    db_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role to set as a default in the
    /// namespace.
    default_iam_role_arn: ?[]const u8 = null,

    /// A list of IAM roles to associate with the namespace.
    iam_roles: ?[]const []const u8 = null,

    /// The ID of the Amazon Web Services Key Management Service key used to encrypt
    /// your data.
    kms_key_id: ?[]const u8 = null,

    /// The types of logs the namespace can export. Available export types are
    /// `userlog`, `connectionlog`, and `useractivitylog`.
    log_exports: ?[]const LogExport = null,

    /// If `true`, Amazon Redshift uses Secrets Manager to manage the namespace's
    /// admin credentials. You can't use `adminUserPassword` if
    /// `manageAdminPassword` is true. If `manageAdminPassword` is false or not set,
    /// Amazon Redshift uses `adminUserPassword` for the admin user account's
    /// password.
    manage_admin_password: ?bool = null,

    /// The name of the namespace.
    namespace_name: []const u8,

    /// The ARN for the Redshift application that integrates with IAM Identity
    /// Center.
    redshift_idc_application_arn: ?[]const u8 = null,

    /// A list of tag instances.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .admin_password_secret_kms_key_id = "adminPasswordSecretKmsKeyId",
        .admin_username = "adminUsername",
        .admin_user_password = "adminUserPassword",
        .db_name = "dbName",
        .default_iam_role_arn = "defaultIamRoleArn",
        .iam_roles = "iamRoles",
        .kms_key_id = "kmsKeyId",
        .log_exports = "logExports",
        .manage_admin_password = "manageAdminPassword",
        .namespace_name = "namespaceName",
        .redshift_idc_application_arn = "redshiftIdcApplicationArn",
        .tags = "tags",
    };
};

pub const CreateNamespaceOutput = struct {
    /// The created namespace object.
    namespace: ?Namespace = null,

    pub const json_field_names = .{
        .namespace = "namespace",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNamespaceInput, options: CallOptions) !CreateNamespaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNamespaceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.CreateNamespace");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNamespaceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateNamespaceOutput, body, allocator);
}
