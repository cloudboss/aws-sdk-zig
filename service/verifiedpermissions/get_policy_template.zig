const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetPolicyTemplateInput = struct {
    /// Specifies the ID of the policy store that contains the policy template that
    /// you want information about.
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

    /// Specifies the ID of the policy template that you want information about.
    ///
    /// You can use the policy template name in place of the policy template ID.
    /// When using a name, prefix it with `name/`. For example:
    ///
    /// * ID: `PTEXAMPLEabcdefg111111`
    /// * Name: `name/example-policy-template`
    policy_template_id: []const u8,

    pub const json_field_names = .{
        .policy_store_id = "policyStoreId",
        .policy_template_id = "policyTemplateId",
    };
};

pub const GetPolicyTemplateOutput = struct {
    /// The date and time that the policy template was originally created.
    created_date: i64,

    /// The description of the policy template.
    description: ?[]const u8 = null,

    /// The date and time that the policy template was most recently updated.
    last_updated_date: i64,

    /// The name of the policy template, if one was assigned when the policy
    /// template was created or last updated.
    name: ?[]const u8 = null,

    /// The ID of the policy store that contains the policy template.
    policy_store_id: []const u8,

    /// The ID of the policy template.
    policy_template_id: []const u8,

    /// The content of the body of the policy template written in the Cedar policy
    /// language.
    statement: []const u8,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .description = "description",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .policy_store_id = "policyStoreId",
        .policy_template_id = "policyTemplateId",
        .statement = "statement",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicyTemplateInput, options: CallOptions) !GetPolicyTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPolicyTemplateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.GetPolicyTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPolicyTemplateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetPolicyTemplateOutput, body, allocator);
}
