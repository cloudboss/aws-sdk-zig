const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Modifies the details of a secret, including metadata and the secret value.
/// To change
/// the secret value, you can also use PutSecretValue.
///
/// To change the rotation configuration of a secret, use RotateSecret
/// instead.
///
/// To change a secret so that it is managed by another service, you need to
/// recreate the
/// secret in that service. See [Secrets Manager secrets
/// managed by other Amazon Web Services
/// services](https://docs.aws.amazon.com/secretsmanager/latest/userguide/service-linked-secrets.html).
///
/// We recommend you avoid calling `UpdateSecret` at a sustained rate of more
/// than once every 10 minutes. When you call `UpdateSecret` to update the
/// secret
/// value, Secrets Manager creates a new version of the secret. Secrets Manager
/// removes outdated versions when
/// there are more than 100, but it does not remove versions created less than
/// 24 hours ago.
/// If you update the secret value more than once every 10 minutes, you create
/// more versions
/// than Secrets Manager removes, and you will reach the quota for secret
/// versions.
///
/// If you include `SecretString` or `SecretBinary` to create a new
/// secret version, Secrets Manager automatically moves the staging label
/// `AWSCURRENT` to
/// the new version. Then it attaches the label `AWSPREVIOUS` to the version
/// that
/// `AWSCURRENT` was removed from.
///
/// If you call this operation with a `ClientRequestToken` that matches an
/// existing version's `VersionId`, the operation results in an error. You can't
/// modify an existing version, you can only create a new version. To remove a
/// version,
/// remove all staging labels from it. See UpdateSecretVersionStage.
///
/// Secrets Manager generates a CloudTrail log entry when you call this action.
/// Do not include sensitive information in request parameters except
/// `SecretBinary` or `SecretString` because it might be logged.
/// For more information, see [Logging Secrets Manager events with
/// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
///
/// **Required permissions:
/// **
/// `secretsmanager:UpdateSecret`. For more information, see [
/// IAM policy actions for Secrets
/// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
/// and access control in Secrets
/// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html). If you use a
/// customer managed key, you must also have `kms:GenerateDataKey`,
/// `kms:Encrypt`, and `kms:Decrypt` permissions on the key. If
/// you change the KMS key and you don't have `kms:Encrypt` permission to the
/// new
/// key, Secrets Manager does not re-encrypt existing secret versions with the
/// new key. For more
/// information, see [ Secret encryption
/// and
/// decryption](https://docs.aws.amazon.com/secretsmanager/latest/userguide/security-encryption.html).
///
/// **Important:**
///
/// When you enter commands in a command shell, there is a risk of the command
/// history being accessed or utilities having access to your command
/// parameters. This is a concern if the command includes the value of a secret.
/// Learn how to [Mitigate the risks of using command-line tools to store
/// Secrets Manager
/// secrets](https://docs.aws.amazon.com/secretsmanager/latest/userguide/security_cli-exposure-risks.html).
pub const UpdateSecretInput = struct {
    /// If you include `SecretString` or `SecretBinary`, then Secrets Manager
    /// creates a new version for the secret, and this parameter specifies the
    /// unique identifier
    /// for the new version.
    ///
    /// **Note:**
    ///
    /// If you use the Amazon Web Services CLI or one of the Amazon Web Services
    /// SDKs to call this operation, then you can leave this parameter empty. The
    /// CLI or SDK generates a random UUID for you and includes it as the value for
    /// this parameter in the request.
    ///
    /// If you generate a raw HTTP request to the Secrets Manager service endpoint,
    /// then you must generate a `ClientRequestToken` and include it in the request.
    ///
    /// This value helps ensure idempotency. Secrets Manager uses this value to
    /// prevent the accidental creation of duplicate versions if there are failures
    /// and retries during a rotation. We recommend that you generate a
    /// [UUID-type](https://wikipedia.org/wiki/Universally_unique_identifier) value
    /// to ensure uniqueness of your versions within the specified secret.
    client_request_token: ?[]const u8 = null,

    /// The description of the secret.
    description: ?[]const u8 = null,

    /// The ARN, key ID, or alias of the KMS key that Secrets Manager uses to
    /// encrypt new
    /// secret versions as well as any existing versions with the staging labels
    /// `AWSCURRENT`, `AWSPENDING`, or `AWSPREVIOUS`. If
    /// you don't have `kms:Encrypt` permission to the new key, Secrets Manager does
    /// not
    /// re-encrypt existing secret versions with the new key. For more information
    /// about
    /// versions and staging labels, see [Concepts:
    /// Version](https://docs.aws.amazon.com/secretsmanager/latest/userguide/getting-started.html#term_version).
    ///
    /// A key alias is always prefixed by `alias/`, for example
    /// `alias/aws/secretsmanager`. For more information, see [About
    /// aliases](https://docs.aws.amazon.com/kms/latest/developerguide/alias-about.html).
    ///
    /// If you set this to an empty string, Secrets Manager uses the Amazon Web
    /// Services managed key
    /// `aws/secretsmanager`. If this key doesn't already exist in your account,
    /// then Secrets Manager creates it for you automatically. All users and roles
    /// in the Amazon Web Services account
    /// automatically have access to use `aws/secretsmanager`. Creating
    /// `aws/secretsmanager` can result in a one-time significant delay in
    /// returning the result.
    ///
    /// **Important:**
    ///
    /// You can only use the Amazon Web Services managed key
    /// `aws/secretsmanager` if you call this operation using credentials from
    /// the same Amazon Web Services account that owns the secret. If the secret is
    /// in a different
    /// account, then you must use a customer managed key and provide the ARN of
    /// that
    /// KMS key in this field. The user making the call must have
    /// permissions to both the secret and the KMS key in their respective
    /// accounts.
    kms_key_id: ?[]const u8 = null,

    /// The binary data to encrypt and store in the new version of the secret. We
    /// recommend
    /// that you store your binary data in a file and then pass the contents of the
    /// file as a
    /// parameter.
    ///
    /// Either `SecretBinary` or `SecretString` must have a value, but
    /// not both.
    ///
    /// You can't access this parameter in the Secrets Manager console.
    ///
    /// Sensitive: This field contains sensitive information, so the service does
    /// not include it in CloudTrail log entries. If you create your own log
    /// entries, you must also avoid logging the information in this field.
    secret_binary: ?[]const u8 = null,

    /// The ARN or name of the secret.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    /// The text data to encrypt and store in the new version of the secret. We
    /// recommend you
    /// use a JSON structure of key/value pairs for your secret value.
    ///
    /// Either `SecretBinary` or `SecretString` must have a value, but
    /// not both.
    ///
    /// Sensitive: This field contains sensitive information, so the service does
    /// not include it in CloudTrail log entries. If you create your own log
    /// entries, you must also avoid logging the information in this field.
    secret_string: ?[]const u8 = null,

    /// The exact string that identifies the third-party partner that holds the
    /// external
    /// secret. For more information, see [Managed external secret
    /// partners](https://docs.aws.amazon.com/secretsmanager/latest/userguide/mes-partners.html).
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .description = "Description",
        .kms_key_id = "KmsKeyId",
        .secret_binary = "SecretBinary",
        .secret_id = "SecretId",
        .secret_string = "SecretString",
        .@"type" = "Type",
    };
};

pub const UpdateSecretOutput = struct {
    /// The ARN of the secret that was updated.
    arn: ?[]const u8 = null,

    /// The name of the secret that was updated.
    name: ?[]const u8 = null,

    /// If Secrets Manager created a new version of the secret during this
    /// operation, then
    /// `VersionId` contains the unique identifier of the new version.
    version_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *UpdateSecretOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .arn = "ARN",
        .name = "Name",
        .version_id = "VersionId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: UpdateSecretInput, options: Options) !UpdateSecretOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "secretsmanager");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateSecretInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("secretsmanager", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "secretsmanager.UpdateSecret");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateSecretOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSecretOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";

    if (std.mem.eql(u8, error_code, "DecryptionFailure")) {
        return .{ .decryption_failure = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionFailure")) {
        return .{ .encryption_failure = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .internal_service_error = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .invalid_next_token_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .invalid_parameter_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .invalid_request_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .malformed_policy_document_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        return .{ .precondition_not_met_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PublicPolicyException")) {
        return .{ .public_policy_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .resource_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = "",
        .http_status = status,
    } };
}
