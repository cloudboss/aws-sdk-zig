const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomerManagedPolicyReference = @import("customer_managed_policy_reference.zig").CustomerManagedPolicyReference;

pub const DetachCustomerManagedPolicyReferenceFromPermissionSetInput = struct {
    /// Specifies the name and path of a customer managed policy. You must have an
    /// IAM policy that matches the name and path in each Amazon Web Services
    /// account where you want to deploy your permission set.
    customer_managed_policy_reference: CustomerManagedPolicyReference,

    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed.
    instance_arn: []const u8,

    /// The ARN of the `PermissionSet`.
    permission_set_arn: []const u8,

    pub const json_field_names = .{
        .customer_managed_policy_reference = "CustomerManagedPolicyReference",
        .instance_arn = "InstanceArn",
        .permission_set_arn = "PermissionSetArn",
    };
};

pub const DetachCustomerManagedPolicyReferenceFromPermissionSetOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetachCustomerManagedPolicyReferenceFromPermissionSetInput, options: CallOptions) !DetachCustomerManagedPolicyReferenceFromPermissionSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetachCustomerManagedPolicyReferenceFromPermissionSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.DetachCustomerManagedPolicyReferenceFromPermissionSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetachCustomerManagedPolicyReferenceFromPermissionSetOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
