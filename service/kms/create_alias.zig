const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;

pub const CreateAliasInput = struct {
    /// Specifies the alias name. This value must begin with `alias/` followed by a
    /// name, such as `alias/ExampleAlias`.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    ///
    /// The `AliasName` value must be string of 1-256 characters. It can contain
    /// only
    /// alphanumeric characters, forward slashes (/), underscores (_), and dashes
    /// (-). The alias name
    /// cannot begin with `alias/aws/`. The `alias/aws/` prefix is reserved for
    /// [Amazon Web Services managed
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-key).
    alias_name: []const u8,

    /// Associates the alias with the specified [customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-mgn-key). The KMS key
    /// must be in the same Amazon Web Services Region.
    ///
    /// A valid key ID is required. If you supply a null or empty string value, this
    /// operation
    /// returns an error.
    ///
    /// For help finding the key ID and ARN, see [Find the key ID and key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/find-cmk-id-arn.html) in
    /// the *
    /// Key Management Service Developer Guide*
    /// .
    ///
    /// Specify the key ID or key ARN of the KMS key.
    ///
    /// For example:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey.
    target_key_id: []const u8,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .target_key_id = "TargetKeyId",
    };
};

pub const CreateAliasOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAliasInput, options: CallOptions) !CreateAliasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kms", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kms", "KMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.CreateAlias");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAliasOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        const parsed_error: ?errors.AlreadyExistsException = aws.json.parseJsonObject(errors.AlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterInUseException")) {
        const parsed_error: ?errors.CloudHsmClusterInUseException = aws.json.parseJsonObject(errors.CloudHsmClusterInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterInvalidConfigurationException")) {
        const parsed_error: ?errors.CloudHsmClusterInvalidConfigurationException = aws.json.parseJsonObject(errors.CloudHsmClusterInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterNotActiveException")) {
        const parsed_error: ?errors.CloudHsmClusterNotActiveException = aws.json.parseJsonObject(errors.CloudHsmClusterNotActiveException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_not_active_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterNotFoundException")) {
        const parsed_error: ?errors.CloudHsmClusterNotFoundException = aws.json.parseJsonObject(errors.CloudHsmClusterNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterNotRelatedException")) {
        const parsed_error: ?errors.CloudHsmClusterNotRelatedException = aws.json.parseJsonObject(errors.CloudHsmClusterNotRelatedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_not_related_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreHasCMKsException")) {
        const parsed_error: ?errors.CustomKeyStoreHasCMKsException = aws.json.parseJsonObject(errors.CustomKeyStoreHasCMKsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_key_store_has_cm_ks_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreInvalidStateException")) {
        const parsed_error: ?errors.CustomKeyStoreInvalidStateException = aws.json.parseJsonObject(errors.CustomKeyStoreInvalidStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_key_store_invalid_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreNameInUseException")) {
        const parsed_error: ?errors.CustomKeyStoreNameInUseException = aws.json.parseJsonObject(errors.CustomKeyStoreNameInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_key_store_name_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreNotFoundException")) {
        const parsed_error: ?errors.CustomKeyStoreNotFoundException = aws.json.parseJsonObject(errors.CustomKeyStoreNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_key_store_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DependencyTimeoutException")) {
        const parsed_error: ?errors.DependencyTimeoutException = aws.json.parseJsonObject(errors.DependencyTimeoutException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .dependency_timeout_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DisabledException")) {
        const parsed_error: ?errors.DisabledException = aws.json.parseJsonObject(errors.DisabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .disabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DryRunOperationException")) {
        const parsed_error: ?errors.DryRunOperationException = aws.json.parseJsonObject(errors.DryRunOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .dry_run_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExpiredImportTokenException")) {
        const parsed_error: ?errors.ExpiredImportTokenException = aws.json.parseJsonObject(errors.ExpiredImportTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .expired_import_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncorrectKeyException")) {
        const parsed_error: ?errors.IncorrectKeyException = aws.json.parseJsonObject(errors.IncorrectKeyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incorrect_key_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncorrectKeyMaterialException")) {
        const parsed_error: ?errors.IncorrectKeyMaterialException = aws.json.parseJsonObject(errors.IncorrectKeyMaterialException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incorrect_key_material_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncorrectTrustAnchorException")) {
        const parsed_error: ?errors.IncorrectTrustAnchorException = aws.json.parseJsonObject(errors.IncorrectTrustAnchorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incorrect_trust_anchor_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAliasNameException")) {
        const parsed_error: ?errors.InvalidAliasNameException = aws.json.parseJsonObject(errors.InvalidAliasNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_alias_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidArnException")) {
        const parsed_error: ?errors.InvalidArnException = aws.json.parseJsonObject(errors.InvalidArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCiphertextException")) {
        const parsed_error: ?errors.InvalidCiphertextException = aws.json.parseJsonObject(errors.InvalidCiphertextException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ciphertext_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidGrantIdException")) {
        const parsed_error: ?errors.InvalidGrantIdException = aws.json.parseJsonObject(errors.InvalidGrantIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_grant_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidGrantTokenException")) {
        const parsed_error: ?errors.InvalidGrantTokenException = aws.json.parseJsonObject(errors.InvalidGrantTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_grant_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidImportTokenException")) {
        const parsed_error: ?errors.InvalidImportTokenException = aws.json.parseJsonObject(errors.InvalidImportTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_import_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyUsageException")) {
        const parsed_error: ?errors.InvalidKeyUsageException = aws.json.parseJsonObject(errors.InvalidKeyUsageException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_key_usage_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMarkerException")) {
        const parsed_error: ?errors.InvalidMarkerException = aws.json.parseJsonObject(errors.InvalidMarkerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_marker_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KeyUnavailableException")) {
        const parsed_error: ?errors.KeyUnavailableException = aws.json.parseJsonObject(errors.KeyUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .key_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSInternalException")) {
        const parsed_error: ?errors.KMSInternalException = aws.json.parseJsonObject(errors.KMSInternalException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_internal_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidMacException")) {
        const parsed_error: ?errors.KMSInvalidMacException = aws.json.parseJsonObject(errors.KMSInvalidMacException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_mac_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidSignatureException")) {
        const parsed_error: ?errors.KMSInvalidSignatureException = aws.json.parseJsonObject(errors.KMSInvalidSignatureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_signature_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        const parsed_error: ?errors.KMSInvalidStateException = aws.json.parseJsonObject(errors.KMSInvalidStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        const parsed_error: ?errors.MalformedPolicyDocumentException = aws.json.parseJsonObject(errors.MalformedPolicyDocumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        const parsed_error: ?errors.NotFoundException = aws.json.parseJsonObject(errors.NotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagException")) {
        const parsed_error: ?errors.TagException = aws.json.parseJsonObject(errors.TagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        const parsed_error: ?errors.UnsupportedOperationException = aws.json.parseJsonObject(errors.UnsupportedOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksKeyAlreadyInUseException")) {
        const parsed_error: ?errors.XksKeyAlreadyInUseException = aws.json.parseJsonObject(errors.XksKeyAlreadyInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_key_already_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksKeyInvalidConfigurationException")) {
        const parsed_error: ?errors.XksKeyInvalidConfigurationException = aws.json.parseJsonObject(errors.XksKeyInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_key_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksKeyNotFoundException")) {
        const parsed_error: ?errors.XksKeyNotFoundException = aws.json.parseJsonObject(errors.XksKeyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_key_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyIncorrectAuthenticationCredentialException")) {
        const parsed_error: ?errors.XksProxyIncorrectAuthenticationCredentialException = aws.json.parseJsonObject(errors.XksProxyIncorrectAuthenticationCredentialException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_incorrect_authentication_credential_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyInvalidConfigurationException")) {
        const parsed_error: ?errors.XksProxyInvalidConfigurationException = aws.json.parseJsonObject(errors.XksProxyInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyInvalidResponseException")) {
        const parsed_error: ?errors.XksProxyInvalidResponseException = aws.json.parseJsonObject(errors.XksProxyInvalidResponseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_invalid_response_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyUriEndpointInUseException")) {
        const parsed_error: ?errors.XksProxyUriEndpointInUseException = aws.json.parseJsonObject(errors.XksProxyUriEndpointInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_uri_endpoint_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyUriInUseException")) {
        const parsed_error: ?errors.XksProxyUriInUseException = aws.json.parseJsonObject(errors.XksProxyUriInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_uri_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyUriUnreachableException")) {
        const parsed_error: ?errors.XksProxyUriUnreachableException = aws.json.parseJsonObject(errors.XksProxyUriUnreachableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_uri_unreachable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyVpcEndpointServiceInUseException")) {
        const parsed_error: ?errors.XksProxyVpcEndpointServiceInUseException = aws.json.parseJsonObject(errors.XksProxyVpcEndpointServiceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_vpc_endpoint_service_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyVpcEndpointServiceInvalidConfigurationException")) {
        const parsed_error: ?errors.XksProxyVpcEndpointServiceInvalidConfigurationException = aws.json.parseJsonObject(errors.XksProxyVpcEndpointServiceInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_vpc_endpoint_service_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyVpcEndpointServiceNotFoundException")) {
        const parsed_error: ?errors.XksProxyVpcEndpointServiceNotFoundException = aws.json.parseJsonObject(errors.XksProxyVpcEndpointServiceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_vpc_endpoint_service_not_found_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
