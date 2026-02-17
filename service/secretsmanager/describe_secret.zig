const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExternalSecretRotationMetadataItem = @import("external_secret_rotation_metadata_item.zig").ExternalSecretRotationMetadataItem;
const ReplicationStatusType = @import("replication_status_type.zig").ReplicationStatusType;
const RotationRulesType = @import("rotation_rules_type.zig").RotationRulesType;
const Tag = @import("tag.zig").Tag;

pub const DescribeSecretInput = struct {
    /// The ARN or name of the secret.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    pub const json_field_names = .{
        .secret_id = "SecretId",
    };
};

pub const DescribeSecretOutput = struct {
    /// The ARN of the secret.
    arn: ?[]const u8 = null,

    /// The date the secret was created.
    created_date: ?i64 = null,

    /// The date the secret is scheduled for deletion. If it is not scheduled for
    /// deletion,
    /// this field is omitted. When you delete a secret, Secrets Manager requires a
    /// recovery window of at
    /// least 7 days before deleting the secret. Some time after the deleted date,
    /// Secrets Manager deletes
    /// the secret, including all of its versions.
    ///
    /// If a secret is scheduled for deletion, then its details, including the
    /// encrypted
    /// secret value, is not accessible. To cancel a scheduled deletion and restore
    /// access to
    /// the secret, use RestoreSecret.
    deleted_date: ?i64 = null,

    /// The description of the secret.
    description: ?[]const u8 = null,

    /// The metadata needed to successfully rotate a managed external secret. A list
    /// of key
    /// value pairs in JSON format specified by the partner. For more information
    /// about the
    /// required information, see [Managed external secrets
    /// partners](https://docs.aws.amazon.com/secretsmanager/latest/userguide/mes-partners.html).
    external_secret_rotation_metadata: ?[]const ExternalSecretRotationMetadataItem = null,

    /// The Amazon Resource Name (ARN) of the role that allows Secrets Manager to
    /// rotate a secret held
    /// by a third-party partner. For more information, see [Security and
    /// permissions](https://docs.aws.amazon.com/secretsmanager/latest/userguide/mes-security.html).
    external_secret_rotation_role_arn: ?[]const u8 = null,

    /// The key ID or alias ARN of the KMS key that Secrets Manager uses to encrypt
    /// the secret value.
    /// If the secret is encrypted with the Amazon Web Services managed key
    /// `aws/secretsmanager`, this field is omitted. Secrets created using the
    /// console use an KMS key ID.
    kms_key_id: ?[]const u8 = null,

    /// The date that the secret was last accessed in the Region. This field is
    /// omitted if the
    /// secret has never been retrieved in the Region.
    last_accessed_date: ?i64 = null,

    /// The last date and time that this secret was modified in any way.
    last_changed_date: ?i64 = null,

    /// The last date and time that Secrets Manager rotated the secret. If the
    /// secret isn't configured
    /// for rotation or rotation has been disabled, Secrets Manager returns null.
    last_rotated_date: ?i64 = null,

    /// The name of the secret.
    name: ?[]const u8 = null,

    /// The next rotation is scheduled to occur on or before this date. If the
    /// secret isn't
    /// configured for rotation or rotation has been disabled, Secrets Manager
    /// returns null. If rotation
    /// fails, Secrets Manager retries the entire rotation process multiple times.
    /// If rotation
    /// is unsuccessful, this date may be in the past.
    ///
    /// This date represents the latest date that rotation will occur, but it is not
    /// an
    /// approximate rotation date. In some cases, for example if you turn off
    /// automatic rotation
    /// and then turn it back on, the next rotation may occur much sooner than this
    /// date.
    next_rotation_date: ?i64 = null,

    /// The ID of the service that created this secret. For more information, see
    /// [Secrets managed by
    /// other Amazon Web Services
    /// services](https://docs.aws.amazon.com/secretsmanager/latest/userguide/service-linked-secrets.html).
    owning_service: ?[]const u8 = null,

    /// The Region the secret is in. If a secret is replicated to other Regions, the
    /// replicas
    /// are listed in `ReplicationStatus`.
    primary_region: ?[]const u8 = null,

    /// A list of the replicas of this secret and their status:
    ///
    /// * `Failed`, which indicates that the replica was not created.
    ///
    /// * `InProgress`, which indicates that Secrets Manager is in the process of
    /// creating the replica.
    ///
    /// * `InSync`, which indicates that the replica was created.
    replication_status: ?[]const ReplicationStatusType = null,

    /// Specifies whether automatic rotation is turned on for this secret. If the
    /// secret has
    /// never been configured for rotation, Secrets Manager returns null.
    ///
    /// To turn on rotation, use RotateSecret. To turn off rotation, use
    /// CancelRotateSecret.
    rotation_enabled: ?bool = null,

    /// The ARN of the Lambda function that Secrets Manager invokes to rotate the
    /// secret.
    rotation_lambda_arn: ?[]const u8 = null,

    /// The rotation schedule and Lambda function for this secret. If the secret
    /// previously had
    /// rotation turned on, but it is now turned off, this field shows the previous
    /// rotation
    /// schedule and rotation function. If the secret never had rotation turned on,
    /// this field
    /// is omitted.
    rotation_rules: ?RotationRulesType = null,

    /// The list of tags attached to the secret. To add tags to a secret, use
    /// TagResource. To remove tags, use UntagResource.
    tags: ?[]const Tag = null,

    /// The exact string that identifies the partner that holds the external secret.
    /// For more
    /// information, see [Using Secrets Manager managed external
    /// secrets](https://docs.aws.amazon.com/secretsmanager/latest/userguide/managed-external-secrets.html).
    @"type": ?[]const u8 = null,

    /// A list of the versions of the secret that have staging labels attached.
    /// Versions that
    /// don't have staging labels are considered deprecated and Secrets Manager can
    /// delete them.
    ///
    /// Secrets Manager uses staging labels to indicate the status of a secret
    /// version during rotation.
    /// The three staging labels for rotation are:
    ///
    /// * `AWSCURRENT`, which indicates the current version of the
    /// secret.
    ///
    /// * `AWSPENDING`, which indicates the version of the secret that
    /// contains new secret information that will become the next current version
    /// when
    /// rotation finishes.
    ///
    /// During rotation, Secrets Manager creates an `AWSPENDING` version ID before
    /// creating the new secret version. To check if a secret version exists, call
    /// GetSecretValue.
    ///
    /// * `AWSPREVIOUS`, which indicates the previous current version of the
    /// secret. You can use this as the *last known good*
    /// version.
    ///
    /// For more information about rotation and staging labels, see [How rotation
    /// works](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotate-secrets_how.html).
    version_ids_to_stages: ?[]const aws.map.MapEntry([]const []const u8) = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeSecretOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .arn = "ARN",
        .created_date = "CreatedDate",
        .deleted_date = "DeletedDate",
        .description = "Description",
        .external_secret_rotation_metadata = "ExternalSecretRotationMetadata",
        .external_secret_rotation_role_arn = "ExternalSecretRotationRoleArn",
        .kms_key_id = "KmsKeyId",
        .last_accessed_date = "LastAccessedDate",
        .last_changed_date = "LastChangedDate",
        .last_rotated_date = "LastRotatedDate",
        .name = "Name",
        .next_rotation_date = "NextRotationDate",
        .owning_service = "OwningService",
        .primary_region = "PrimaryRegion",
        .replication_status = "ReplicationStatus",
        .rotation_enabled = "RotationEnabled",
        .rotation_lambda_arn = "RotationLambdaARN",
        .rotation_rules = "RotationRules",
        .tags = "Tags",
        .@"type" = "Type",
        .version_ids_to_stages = "VersionIdsToStages",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeSecretInput, options: Options) !DescribeSecretOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeSecretInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "secretsmanager.DescribeSecret");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeSecretOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSecretOutput, body, alloc);
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
