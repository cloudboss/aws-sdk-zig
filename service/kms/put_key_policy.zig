const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutKeyPolicyInput = struct {
    /// Skips ("bypasses") the key policy lockout safety check. The default value is
    /// false.
    ///
    /// Setting this value to true increases the risk that the KMS key becomes
    /// unmanageable. Do
    /// not set this value to true indiscriminately.
    ///
    /// For more information, see [Default key
    /// policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#prevent-unmanageable-key) in the *Key Management Service Developer Guide*.
    ///
    /// Use this parameter only when you intend to prevent the principal that is
    /// making the
    /// request from making a subsequent
    /// [PutKeyPolicy](https://docs.aws.amazon.com/kms/latest/APIReference/API_PutKeyPolicy.html)
    /// request on the KMS key.
    bypass_policy_lockout_safety_check: ?bool = null,

    /// Sets the key policy on the specified KMS key.
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
    key_id: []const u8,

    /// The key policy to attach to the KMS key.
    ///
    /// The key policy must meet the following criteria:
    ///
    /// * The key policy must allow the calling principal to make a
    /// subsequent `PutKeyPolicy` request on the KMS key. This reduces the risk that
    /// the KMS key becomes unmanageable. For more information, see [Default key
    /// policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#prevent-unmanageable-key) in the *Key Management Service Developer Guide*. (To omit
    /// this condition, set `BypassPolicyLockoutSafetyCheck` to true.)
    ///
    /// * Each statement in the key policy must contain one or more principals. The
    ///   principals
    /// in the key policy must exist and be visible to KMS. When you create a new
    /// Amazon Web Services
    /// principal, you might need to enforce a delay before including the new
    /// principal in a key
    /// policy because the new principal might not be immediately visible to KMS.
    /// For more
    /// information, see [Changes that I make are not always immediately
    /// visible](https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot_general.html#troubleshoot_general_eventual-consistency) in the *Amazon Web Services
    /// Identity and Access Management User Guide*.
    ///
    /// If either of the required `Resource` or `Action` elements are
    /// missing from a key policy statement, the policy statement has no effect.
    /// When a key policy
    /// statement is missing one of these elements, the KMS console correctly
    /// reports an error,
    /// but the `PutKeyPolicy` API request succeeds, even though the policy
    /// statement is
    /// ineffective.
    ///
    /// For more information on required key policy elements, see [Elements in a key
    /// policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-overview.html#key-policy-elements) in the *Key Management Service Developer Guide*.
    ///
    /// A key policy document can include only the following characters:
    ///
    /// * Printable ASCII characters from the space character (`\u0020`) through the
    ///   end of the ASCII character range.
    ///
    /// * Printable characters in the Basic Latin and Latin-1 Supplement character
    ///   set (through `\u00FF`).
    ///
    /// * The tab (`\u0009`), line feed (`\u000A`), and carriage return (`\u000D`)
    ///   special characters
    ///
    /// If the key policy exceeds the length constraint, KMS returns a
    /// `LimitExceededException`.
    ///
    /// For information about key policies, see [Key policies in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html) in the
    /// *Key Management Service Developer Guide*.For help writing and formatting a
    /// JSON policy document, see the [IAM JSON Policy
    /// Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies.html) in the *
    /// Identity and Access Management User Guide*
    /// .
    policy: []const u8,

    /// The name of the key policy. If no policy name is specified, the default
    /// value is
    /// `default`. The only valid value is `default`.
    policy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .bypass_policy_lockout_safety_check = "BypassPolicyLockoutSafetyCheck",
        .key_id = "KeyId",
        .policy = "Policy",
        .policy_name = "PolicyName",
    };
};

pub const PutKeyPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutKeyPolicyInput, options: CallOptions) !PutKeyPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutKeyPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.PutKeyPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutKeyPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
