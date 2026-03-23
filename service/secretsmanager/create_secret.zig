const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ReplicaRegionType = @import("replica_region_type.zig").ReplicaRegionType;
const Tag = @import("tag.zig").Tag;
const ReplicationStatusType = @import("replication_status_type.zig").ReplicationStatusType;

pub const CreateSecretInput = struct {
    /// A list of Regions and KMS keys to replicate secrets.
    add_replica_regions: ?[]const ReplicaRegionType = null,

    /// If you include `SecretString` or `SecretBinary`, then Secrets Manager
    /// creates an initial version for the secret, and this parameter specifies the
    /// unique
    /// identifier for the new version.
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
    ///
    /// * If the `ClientRequestToken` value isn't already associated with a
    /// version of the secret then a new version of the secret is created.
    ///
    /// * If a version with this value already exists and the version
    /// `SecretString` and `SecretBinary` values are the same
    /// as those in the request, then the request is ignored.
    ///
    /// * If a version with this value already exists and that version's
    /// `SecretString` and `SecretBinary` values are different
    /// from those in the request, then the request fails because you cannot modify
    /// an
    /// existing version. Instead, use PutSecretValue to create a new
    /// version.
    ///
    /// This value becomes the `VersionId` of the new version.
    client_request_token: ?[]const u8 = null,

    /// The description of the secret.
    description: ?[]const u8 = null,

    /// Specifies whether to overwrite a secret with the same name in the
    /// destination Region.
    /// By default, secrets aren't overwritten.
    force_overwrite_replica_secret: ?bool = null,

    /// The ARN, key ID, or alias of the KMS key that Secrets Manager uses to
    /// encrypt the secret value
    /// in the secret. An alias is always prefixed by `alias/`, for example
    /// `alias/aws/secretsmanager`. For more information, see [About
    /// aliases](https://docs.aws.amazon.com/kms/latest/developerguide/alias-about.html).
    ///
    /// To use a KMS key in a different account, use the key ARN or the alias ARN.
    ///
    /// If you don't specify this value, then Secrets Manager uses the key
    /// `aws/secretsmanager`. If that key doesn't yet exist, then Secrets Manager
    /// creates
    /// it for you automatically the first time it encrypts the secret value.
    ///
    /// If the secret is in a different Amazon Web Services account from the
    /// credentials calling the API,
    /// then you can't use `aws/secretsmanager` to encrypt the secret, and you must
    /// create and use a customer managed KMS key.
    kms_key_id: ?[]const u8 = null,

    /// The name of the new secret.
    ///
    /// The secret name can contain ASCII letters, numbers, and the following
    /// characters:
    /// /_+=.@-
    ///
    /// Do not end your secret name with a hyphen followed by six characters. If you
    /// do so,
    /// you risk confusion and unexpected results when searching for a secret by
    /// partial ARN.
    /// Secrets Manager automatically adds a hyphen and six random characters after
    /// the secret name at the
    /// end of the ARN.
    name: []const u8,

    /// The binary data to encrypt and store in the new version of the secret. We
    /// recommend
    /// that you store your binary data in a file and then pass the contents of the
    /// file as a
    /// parameter.
    ///
    /// Either `SecretString` or `SecretBinary` must have a value, but
    /// not both.
    ///
    /// This parameter is not available in the Secrets Manager console.
    ///
    /// Sensitive: This field contains sensitive information, so the service does
    /// not include it in CloudTrail log entries. If you create your own log
    /// entries, you must also avoid logging the information in this field.
    secret_binary: ?[]const u8 = null,

    /// The text data to encrypt and store in this new version of the secret. We
    /// recommend you
    /// use a JSON structure of key/value pairs for your secret value.
    ///
    /// Either `SecretString` or `SecretBinary` must have a value, but
    /// not both.
    ///
    /// If you create a secret by using the Secrets Manager console then Secrets
    /// Manager puts the protected secret
    /// text in only the `SecretString` parameter. The Secrets Manager console
    /// stores the
    /// information as a JSON structure of key/value pairs that a Lambda rotation
    /// function can
    /// parse.
    ///
    /// Sensitive: This field contains sensitive information, so the service does
    /// not include it in CloudTrail log entries. If you create your own log
    /// entries, you must also avoid logging the information in this field.
    secret_string: ?[]const u8 = null,

    /// A list of tags to attach to the secret. Each tag is a key and value pair of
    /// strings in
    /// a JSON text string, for example:
    ///
    /// `[{"Key":"CostCenter","Value":"12345"},{"Key":"environment","Value":"production"}]`
    ///
    /// Secrets Manager tag key names are case sensitive. A tag with the key "ABC"
    /// is a different tag
    /// from one with key "abc".
    ///
    /// If you check tags in permissions policies as part of your security strategy,
    /// then
    /// adding or removing a tag can change permissions. If the completion of this
    /// operation
    /// would result in you losing your permissions for this secret, then Secrets
    /// Manager blocks the
    /// operation and returns an `Access Denied` error. For more information, see
    /// [Control access to secrets using
    /// tags](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_examples.html#tag-secrets-abac) and [Limit access to identities with tags that match secrets' tags](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_examples.html#auth-and-access_tags2).
    ///
    /// For information about how to format a JSON parameter for the various command
    /// line tool
    /// environments, see [Using JSON for
    /// Parameters](https://docs.aws.amazon.com/cli/latest/userguide/cli-using-param.html#cli-using-param-json). If your command-line tool or SDK requires quotation marks around
    /// the parameter, you should use single quotes to avoid confusion with the
    /// double quotes
    /// required in the JSON text.
    ///
    /// For tag quotas and naming restrictions, see [Service quotas for
    /// Tagging](https://docs.aws.amazon.com/general/latest/gr/arg.html#taged-reference-quotas) in the *Amazon Web Services General Reference guide*.
    tags: ?[]const Tag = null,

    /// The exact string that identifies the partner that holds the external secret.
    /// For more
    /// information, see [Using Secrets Manager managed external
    /// secrets](https://docs.aws.amazon.com/secretsmanager/latest/userguide/managed-external-secrets.html).
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .add_replica_regions = "AddReplicaRegions",
        .client_request_token = "ClientRequestToken",
        .description = "Description",
        .force_overwrite_replica_secret = "ForceOverwriteReplicaSecret",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .secret_binary = "SecretBinary",
        .secret_string = "SecretString",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

pub const CreateSecretOutput = struct {
    /// The ARN of the new secret. The ARN includes the name of the secret followed
    /// by six
    /// random characters. This ensures that if you create a new secret with the
    /// same name as a
    /// deleted secret, then users with access to the old secret don't get access to
    /// the new
    /// secret because the ARNs are different.
    arn: ?[]const u8 = null,

    /// The name of the new secret.
    name: ?[]const u8 = null,

    /// A list of the replicas of this secret and their status:
    ///
    /// * `Failed`, which indicates that the replica was not created.
    ///
    /// * `InProgress`, which indicates that Secrets Manager is in the
    /// process of creating the replica.
    ///
    /// * `InSync`, which indicates that the replica was created.
    replication_status: ?[]const ReplicationStatusType = null,

    /// The unique identifier associated with the version of the new secret.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .name = "Name",
        .replication_status = "ReplicationStatus",
        .version_id = "VersionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSecretInput, options: CallOptions) !CreateSecretOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "secretsmanager");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSecretInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("secretsmanager", "Secrets Manager", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "secretsmanager.CreateSecret");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSecretOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSecretOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "DecryptionFailure")) {
        return .{ .arena = arena, .kind = .{ .decryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionFailure")) {
        return .{ .arena = arena, .kind = .{ .encryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        return .{ .arena = arena, .kind = .{ .precondition_not_met_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PublicPolicyException")) {
        return .{ .arena = arena, .kind = .{ .public_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
