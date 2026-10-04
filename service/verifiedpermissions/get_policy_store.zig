const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CedarVersion = @import("cedar_version.zig").CedarVersion;
const DeletionProtection = @import("deletion_protection.zig").DeletionProtection;
const EncryptionState = @import("encryption_state.zig").EncryptionState;
const ValidationSettings = @import("validation_settings.zig").ValidationSettings;

pub const GetPolicyStoreInput = struct {
    /// Specifies the policy store that you want information about.
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

    /// Specifies whether to return the tags that are attached to the policy store.
    /// If this parameter is included in the API call, the tags are returned,
    /// otherwise they are not returned.
    ///
    /// If this parameter is included in the API call but there are no tags attached
    /// to the policy store, the `tags` response parameter is omitted from the
    /// response.
    tags: ?bool = null,

    pub const json_field_names = .{
        .policy_store_id = "policyStoreId",
        .tags = "tags",
    };
};

pub const GetPolicyStoreOutput = struct {
    /// The Amazon Resource Name (ARN) of the policy store.
    arn: []const u8,

    /// The version of the Cedar language used with policies, policy templates, and
    /// schemas in this policy store. For more information, see [Amazon Verified
    /// Permissions upgrade to Cedar v4
    /// FAQ](https://docs.aws.amazon.com/verifiedpermissions/latest/userguide/cedar4-faq.html).
    cedar_version: ?CedarVersion = null,

    /// The date and time that the policy store was originally created.
    created_date: i64,

    /// Specifies whether the policy store can be deleted. If enabled, the policy
    /// store can't be deleted.
    ///
    /// The default state is `DISABLED`.
    deletion_protection: ?DeletionProtection = null,

    /// Descriptive text that you can provide to help with identification of the
    /// current policy store.
    description: ?[]const u8 = null,

    /// A structure that contains the encryption configuration for the policy store.
    encryption_state: ?EncryptionState = null,

    /// The date and time that the policy store was last updated.
    last_updated_date: i64,

    /// The ID of the policy store;
    policy_store_id: []const u8,

    /// The list of tags associated with the policy store.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The current validation settings for the policy store.
    validation_settings: ?ValidationSettings = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cedar_version = "cedarVersion",
        .created_date = "createdDate",
        .deletion_protection = "deletionProtection",
        .description = "description",
        .encryption_state = "encryptionState",
        .last_updated_date = "lastUpdatedDate",
        .policy_store_id = "policyStoreId",
        .tags = "tags",
        .validation_settings = "validationSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicyStoreInput, options: CallOptions) !GetPolicyStoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPolicyStoreInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.GetPolicyStore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPolicyStoreOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetPolicyStoreOutput, body, allocator);
}
