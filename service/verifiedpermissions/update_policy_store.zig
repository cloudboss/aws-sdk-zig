const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletionProtection = @import("deletion_protection.zig").DeletionProtection;
const ValidationSettings = @import("validation_settings.zig").ValidationSettings;

pub const UpdatePolicyStoreInput = struct {
    /// Specifies whether the policy store can be deleted. If enabled, the policy
    /// store can't be deleted.
    ///
    /// When you call `UpdatePolicyStore`, this parameter is unchanged unless
    /// explicitly included in the call.
    deletion_protection: ?DeletionProtection = null,

    /// Descriptive text that you can provide to help with identification of the
    /// current policy store.
    description: ?[]const u8 = null,

    /// Specifies the ID of the policy store that you want to update
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

    /// A structure that defines the validation settings that want to enable for the
    /// policy store.
    validation_settings: ValidationSettings,

    pub const json_field_names = .{
        .deletion_protection = "deletionProtection",
        .description = "description",
        .policy_store_id = "policyStoreId",
        .validation_settings = "validationSettings",
    };
};

pub const UpdatePolicyStoreOutput = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the updated policy store.
    arn: []const u8,

    /// The date and time that the policy store was originally created.
    created_date: i64,

    /// The date and time that the policy store was most recently updated.
    last_updated_date: i64,

    /// The ID of the updated policy store.
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_date = "createdDate",
        .last_updated_date = "lastUpdatedDate",
        .policy_store_id = "policyStoreId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePolicyStoreInput, options: CallOptions) !UpdatePolicyStoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePolicyStoreInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.UpdatePolicyStore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePolicyStoreOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdatePolicyStoreOutput, body, allocator);
}
