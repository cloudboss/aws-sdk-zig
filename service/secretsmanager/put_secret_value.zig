const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const PutSecretValueInput = struct {
    /// A unique identifier for the new version of the secret.
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
    /// * If a version with this value already exists and that version's
    /// `SecretString` or `SecretBinary` values are the same
    /// as those in the request then the request is ignored. The operation is
    /// idempotent.
    ///
    /// * If a version with this value already exists and the version of the
    /// `SecretString` and `SecretBinary` values are different
    /// from those in the request, then the request fails because you can't modify a
    /// secret version. You can only create new versions to store new secret
    /// values.
    ///
    /// This value becomes the `VersionId` of the new version.
    client_request_token: ?[]const u8 = null,

    /// A unique identifier that indicates the source of the request. Required for
    /// secret
    /// rotations using an IAM assumed role or cross-account rotation, in which you
    /// rotate a
    /// secret in one account by using a Lambda rotation function in another
    /// account. In both
    /// cases, the rotation function assumes an IAM role to call Secrets Manager,
    /// and then Secrets Manager validates
    /// the identity using the token. For more information, see [How rotation
    /// works](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html) and [Rotation by Lambda
    /// functions](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotate-secrets_lambda).
    ///
    /// Sensitive: This field contains sensitive information, so the service does
    /// not include it in CloudTrail log entries. If you create your own log
    /// entries, you must also avoid logging the information in this field.
    rotation_token: ?[]const u8 = null,

    /// The binary data to encrypt and store in the new version of the secret. To
    /// use this
    /// parameter in the command-line tools, we recommend that you store your binary
    /// data in a
    /// file and then pass the contents of the file as a parameter.
    ///
    /// You must include `SecretBinary` or `SecretString`, but not
    /// both.
    ///
    /// You can't access this value from the Secrets Manager console.
    ///
    /// Sensitive: This field contains sensitive information, so the service does
    /// not include it in CloudTrail log entries. If you create your own log
    /// entries, you must also avoid logging the information in this field.
    secret_binary: ?[]const u8 = null,

    /// The ARN or name of the secret to add a new version to.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    ///
    /// If the secret doesn't already exist, use `CreateSecret` instead.
    secret_id: []const u8,

    /// The text to encrypt and store in the new version of the secret.
    ///
    /// You must include `SecretBinary` or `SecretString`, but not
    /// both.
    ///
    /// We recommend you create the secret string as JSON key/value pairs, as shown
    /// in the
    /// example.
    ///
    /// Sensitive: This field contains sensitive information, so the service does
    /// not include it in CloudTrail log entries. If you create your own log
    /// entries, you must also avoid logging the information in this field.
    secret_string: ?[]const u8 = null,

    /// A list of staging labels to attach to this version of the secret. Secrets
    /// Manager uses staging
    /// labels to track versions of a secret through the rotation process.
    ///
    /// If you specify a staging label that's already associated with a different
    /// version of
    /// the same secret, then Secrets Manager removes the label from the other
    /// version and attaches it to
    /// this version. If you specify `AWSCURRENT`, and it is already attached to
    /// another version, then Secrets Manager also moves the staging label
    /// `AWSPREVIOUS` to the
    /// version that `AWSCURRENT` was removed from.
    ///
    /// If you don't include `VersionStages`, then Secrets Manager automatically
    /// moves the
    /// staging label `AWSCURRENT` to this version.
    version_stages: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .rotation_token = "RotationToken",
        .secret_binary = "SecretBinary",
        .secret_id = "SecretId",
        .secret_string = "SecretString",
        .version_stages = "VersionStages",
    };
};

pub const PutSecretValueOutput = struct {
    /// The ARN of the secret.
    arn: ?[]const u8 = null,

    /// The name of the secret.
    name: ?[]const u8 = null,

    /// The unique identifier of the version of the secret.
    version_id: ?[]const u8 = null,

    /// The list of staging labels that are currently attached to this version of
    /// the secret.
    /// Secrets Manager uses staging labels to track a version as it progresses
    /// through the secret
    /// rotation process.
    version_stages: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .name = "Name",
        .version_id = "VersionId",
        .version_stages = "VersionStages",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSecretValueInput, options: Options) !PutSecretValueOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutSecretValueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("secretsmanager", "Secrets Manager", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "secretsmanager.PutSecretValue");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutSecretValueOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutSecretValueOutput, body, alloc);
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
