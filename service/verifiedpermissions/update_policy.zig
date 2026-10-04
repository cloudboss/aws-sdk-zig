const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdatePolicyDefinition = @import("update_policy_definition.zig").UpdatePolicyDefinition;
const ActionIdentifier = @import("action_identifier.zig").ActionIdentifier;
const PolicyEffect = @import("policy_effect.zig").PolicyEffect;
const PolicyType = @import("policy_type.zig").PolicyType;
const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;

pub const UpdatePolicyInput = struct {
    /// Specifies the updated policy content that you want to replace on the
    /// specified policy. The content must be valid Cedar policy language text.
    ///
    /// If you don't specify this parameter, the existing policy definition remains
    /// unchanged.
    ///
    /// You can change only the following elements from the policy definition:
    ///
    /// * The `action` referenced by the policy.
    /// * Any conditional clauses, such as `when` or `unless` clauses.
    ///
    /// You **can't** change the following elements:
    ///
    /// * Changing from `static` to `templateLinked`.
    /// * Changing the effect of the policy from `permit` or `forbid`.
    /// * The `principal` referenced by the policy.
    /// * The `resource` referenced by the policy.
    definition: ?UpdatePolicyDefinition = null,

    /// Specifies a name for the policy that is unique among all policies within the
    /// policy store. You can use the name in place of the policy ID in API
    /// operations that reference the policy. The name must be prefixed with
    /// `name/`.
    ///
    /// If you don't include the name in an update request, the existing name is
    /// unchanged. To remove a name, set it to an empty string (`""`).
    ///
    /// If you specify a name that is already associated with another policy in the
    /// policy store, you receive a `ConflictException` error.
    name: ?[]const u8 = null,

    /// Specifies the ID of the policy that you want to update. To find this value,
    /// you can use
    /// [ListPolicies](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicies.html).
    ///
    /// You can use the policy name in place of the policy ID. When using a name,
    /// prefix it with `name/`. For example:
    ///
    /// * ID: `SPEXAMPLEabcdefg111111`
    /// * Name: `name/example-policy`
    policy_id: []const u8,

    /// Specifies the ID of the policy store that contains the policy that you want
    /// to update.
    ///
    /// To specify a policy store, use its ID or alias name. When using an alias
    /// name, prefix it with `policy-store-alias/`. For example:
    ///
    /// * ID: `PSEXAMPLEabcdefg111111`
    /// * Alias name: `policy-store-alias/example-policy-store`
    ///
    /// To view aliases, use
    /// [ListPolicyStoreAliases](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicyStoreAliases.html).
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .definition = "definition",
        .name = "name",
        .policy_id = "policyId",
        .policy_store_id = "policyStoreId",
    };
};

pub const UpdatePolicyOutput = struct {
    /// The action that a policy permits or forbids. For example, `{"actions":
    /// [{"actionId": "ViewPhoto", "actionType": "PhotoFlash::Action"}, {"entityID":
    /// "SharePhoto", "entityType": "PhotoFlash::Action"}]}`.
    actions: ?[]const ActionIdentifier = null,

    /// The date and time that the policy was originally created.
    created_date: i64,

    /// The effect of the decision that a policy returns to an authorization
    /// request. For example, `"effect": "Permit"`.
    effect: ?PolicyEffect = null,

    /// The date and time that the policy was most recently updated.
    last_updated_date: i64,

    /// The ID of the policy that was updated.
    policy_id: []const u8,

    /// The ID of the policy store that contains the policy that was updated.
    policy_store_id: []const u8,

    /// The type of the policy that was updated.
    policy_type: PolicyType,

    /// The principal specified in the policy's scope. This element isn't included
    /// in the response when `Principal` isn't present in the policy content.
    principal: ?EntityIdentifier = null,

    /// The resource specified in the policy's scope. This element isn't included in
    /// the response when `Resource` isn't present in the policy content.
    resource: ?EntityIdentifier = null,

    pub const json_field_names = .{
        .actions = "actions",
        .created_date = "createdDate",
        .effect = "effect",
        .last_updated_date = "lastUpdatedDate",
        .policy_id = "policyId",
        .policy_store_id = "policyStoreId",
        .policy_type = "policyType",
        .principal = "principal",
        .resource = "resource",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePolicyInput, options: CallOptions) !UpdatePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "verifiedpermissions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("verifiedpermissions", "VerifiedPermissions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.UpdatePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePolicyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdatePolicyOutput, body, allocator);
}
