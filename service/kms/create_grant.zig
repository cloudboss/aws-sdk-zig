const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GrantConstraints = @import("grant_constraints.zig").GrantConstraints;
const GrantOperation = @import("grant_operation.zig").GrantOperation;

pub const CreateGrantInput = struct {
    /// Specifies a grant constraint.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    ///
    /// KMS supports the `EncryptionContextEquals` and
    /// `EncryptionContextSubset` grant constraints, which allow the permissions in
    /// the
    /// grant only when the encryption context in the request matches
    /// (`EncryptionContextEquals`) or includes (`EncryptionContextSubset`)
    /// the encryption context specified in the constraint.
    ///
    /// The encryption context grant constraints are supported only on [grant
    /// operations](https://docs.aws.amazon.com/kms/latest/developerguide/grants.html#terms-grant-operations) that include
    /// an `EncryptionContext` parameter, such as cryptographic operations on
    /// symmetric
    /// encryption KMS keys. Grants with grant constraints can include the
    /// DescribeKey and RetireGrant operations, but the constraint doesn't apply to
    /// these
    /// operations. If a grant with a grant constraint includes the `CreateGrant`
    /// operation, the constraint requires that any grants created with the
    /// `CreateGrant`
    /// permission have an equally strict or stricter encryption context constraint.
    ///
    /// You cannot use an encryption context grant constraint for cryptographic
    /// operations with
    /// asymmetric KMS keys or HMAC KMS keys. Operations with these keys don't
    /// support an encryption
    /// context.
    ///
    /// Each constraint value can include up to 8 encryption context pairs. The
    /// encryption context
    /// value in each constraint cannot exceed 384 characters. For information about
    /// grant
    /// constraints, see [Using grant
    /// constraints](https://docs.aws.amazon.com/kms/latest/developerguide/create-grant-overview.html#grant-constraints) in the *Key Management Service Developer Guide*. For more information about encryption context,
    /// see [Encryption
    /// context](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context) in the *
    /// Key Management Service Developer Guide*
    /// .
    constraints: ?GrantConstraints = null,

    /// Checks if your request will succeed. `DryRun` is an optional parameter.
    ///
    /// To learn more about how to use this parameter, see [Testing your
    /// permissions](https://docs.aws.amazon.com/kms/latest/developerguide/testing-permissions.html) in the *Key Management Service Developer Guide*.
    dry_run: ?bool = null,

    /// The identity that gets the permissions specified in the grant.
    ///
    /// To specify the grantee principal, use the Amazon Resource Name (ARN) of an
    /// Amazon Web Services
    /// principal. Valid principals include Amazon Web Services accounts, IAM users,
    /// IAM roles,
    /// federated users, and assumed role users. For help with the ARN syntax for a
    /// principal, see
    /// [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns) in the *
    /// Identity and Access Management User Guide*
    /// .
    grantee_principal: []const u8,

    /// A list of grant tokens.
    ///
    /// Use a grant token when your permission to call this operation comes from a
    /// new grant that has not yet achieved *eventual consistency*. For more
    /// information, see [Grant
    /// token](https://docs.aws.amazon.com/kms/latest/developerguide/grants.html#grant_token) and [Using a grant token](https://docs.aws.amazon.com/kms/latest/developerguide/using-grant-token.html) in the
    /// *Key Management Service Developer Guide*.
    grant_tokens: ?[]const []const u8 = null,

    /// Identifies the KMS key for the grant. The grant gives principals permission
    /// to use this
    /// KMS key.
    ///
    /// Specify the key ID or key ARN of the KMS key. To specify a KMS key in a
    /// different Amazon Web Services account, you must use the key ARN.
    ///
    /// For example:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey.
    key_id: []const u8,

    /// A friendly name for the grant. Use this value to prevent the unintended
    /// creation of
    /// duplicate grants when retrying this request.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    ///
    /// When this value is absent, all `CreateGrant` requests result in a new grant
    /// with a unique `GrantId` even if all the supplied parameters are identical.
    /// This can
    /// result in unintended duplicates when you retry the `CreateGrant` request.
    ///
    /// When this value is present, you can retry a `CreateGrant` request with
    /// identical parameters; if the grant already exists, the original `GrantId` is
    /// returned without creating a new grant. Note that the returned grant token is
    /// unique with every
    /// `CreateGrant` request, even when a duplicate `GrantId` is returned.
    /// All grant tokens for the same grant ID can be used interchangeably.
    name: ?[]const u8 = null,

    /// A list of operations that the grant permits.
    ///
    /// This list must include only operations that are permitted in a grant. Also,
    /// the operation
    /// must be supported on the KMS key. For example, you cannot create a grant for
    /// a symmetric
    /// encryption KMS key that allows the Sign operation, or a grant for an
    /// asymmetric KMS key that allows the GenerateDataKey operation. If you try,
    /// KMS returns a `ValidationError` exception. For details, see [Grant
    /// operations](https://docs.aws.amazon.com/kms/latest/developerguide/grants.html#terms-grant-operations) in the *Key Management Service Developer Guide*.
    operations: []const GrantOperation,

    /// The principal that has permission to use the RetireGrant operation to
    /// retire the grant.
    ///
    /// To specify the principal, use the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of an
    /// Amazon Web Services principal. Valid principals include Amazon Web Services
    /// accounts, IAM users, IAM roles,
    /// federated users, and assumed role users. For help with the ARN syntax for a
    /// principal, see
    /// [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns) in the *
    /// Identity and Access Management User Guide*
    /// .
    ///
    /// The grant determines the retiring principal. Other principals might have
    /// permission to
    /// retire the grant or revoke the grant. For details, see RevokeGrant and
    /// [Retiring and revoking
    /// grants](https://docs.aws.amazon.com/kms/latest/developerguide/grant-delete.html) in the *Key Management Service Developer Guide*.
    retiring_principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .constraints = "Constraints",
        .dry_run = "DryRun",
        .grantee_principal = "GranteePrincipal",
        .grant_tokens = "GrantTokens",
        .key_id = "KeyId",
        .name = "Name",
        .operations = "Operations",
        .retiring_principal = "RetiringPrincipal",
    };
};

pub const CreateGrantOutput = struct {
    /// The unique identifier for the grant.
    ///
    /// You can use the `GrantId` in a ListGrants, RetireGrant, or RevokeGrant
    /// operation.
    grant_id: ?[]const u8 = null,

    /// The grant token.
    ///
    /// Use a grant token when your permission to call this operation comes from a
    /// new grant that has not yet achieved *eventual consistency*. For more
    /// information, see [Grant
    /// token](https://docs.aws.amazon.com/kms/latest/developerguide/grants.html#grant_token) and [Using a grant token](https://docs.aws.amazon.com/kms/latest/developerguide/using-grant-token.html) in the
    /// *Key Management Service Developer Guide*.
    grant_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .grant_id = "GrantId",
        .grant_token = "GrantToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGrantInput, options: CallOptions) !CreateGrantOutput {
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGrantInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.CreateGrant");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGrantOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateGrantOutput, body, allocator);
}
