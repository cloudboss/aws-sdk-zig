const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningStatus = @import("provisioning_status.zig").ProvisioningStatus;

pub const ListAccountsForProvisionedPermissionSetInput = struct {
    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed. For more information about ARNs, see [Amazon Resource Names
    /// (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: []const u8,

    /// The maximum number of results to display for the PermissionSet.
    max_results: ?i32 = null,

    /// The pagination token for the list API. Initially the value is null. Use the
    /// output of previous API calls to make subsequent calls.
    next_token: ?[]const u8 = null,

    /// The ARN of the PermissionSet from which the associated Amazon Web Services
    /// accounts will be listed.
    permission_set_arn: []const u8,

    /// The permission set provisioning status for an Amazon Web Services account.
    provisioning_status: ?ProvisioningStatus = null,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .permission_set_arn = "PermissionSetArn",
        .provisioning_status = "ProvisioningStatus",
    };
};

pub const ListAccountsForProvisionedPermissionSetOutput = struct {
    /// The list of Amazon Web Services `AccountIds`.
    account_ids: ?[]const []const u8 = null,

    /// The pagination token for the list API. Initially the value is null. Use the
    /// output of previous API calls to make subsequent calls.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccountsForProvisionedPermissionSetInput, options: CallOptions) !ListAccountsForProvisionedPermissionSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccountsForProvisionedPermissionSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.ListAccountsForProvisionedPermissionSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccountsForProvisionedPermissionSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAccountsForProvisionedPermissionSetOutput, body, allocator);
}
