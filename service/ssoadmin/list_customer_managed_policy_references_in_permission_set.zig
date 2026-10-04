const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomerManagedPolicyReference = @import("customer_managed_policy_reference.zig").CustomerManagedPolicyReference;

pub const ListCustomerManagedPolicyReferencesInPermissionSetInput = struct {
    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed.
    instance_arn: []const u8,

    /// The maximum number of results to display for the list call.
    max_results: ?i32 = null,

    /// The pagination token for the list API. Initially the value is null. Use the
    /// output of previous API calls to make subsequent calls.
    next_token: ?[]const u8 = null,

    /// The ARN of the `PermissionSet`.
    permission_set_arn: []const u8,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .permission_set_arn = "PermissionSetArn",
    };
};

pub const ListCustomerManagedPolicyReferencesInPermissionSetOutput = struct {
    /// Specifies the names and paths of the customer managed policies that you have
    /// attached to your permission set.
    customer_managed_policy_references: ?[]const CustomerManagedPolicyReference = null,

    /// The pagination token for the list API. Initially the value is null. Use the
    /// output of previous API calls to make subsequent calls.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .customer_managed_policy_references = "CustomerManagedPolicyReferences",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCustomerManagedPolicyReferencesInPermissionSetInput, options: CallOptions) !ListCustomerManagedPolicyReferencesInPermissionSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sso", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCustomerManagedPolicyReferencesInPermissionSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sso", "SSO Admin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.ListCustomerManagedPolicyReferencesInPermissionSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCustomerManagedPolicyReferencesInPermissionSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCustomerManagedPolicyReferencesInPermissionSetOutput, body, allocator);
}
