const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisionTargetType = @import("provision_target_type.zig").ProvisionTargetType;
const PermissionSetProvisioningStatus = @import("permission_set_provisioning_status.zig").PermissionSetProvisioningStatus;

pub const ProvisionPermissionSetInput = struct {
    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed. For more information about ARNs, see [Amazon Resource Names
    /// (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: []const u8,

    /// The ARN of the permission set.
    permission_set_arn: []const u8,

    /// TargetID is an Amazon Web Services account identifier, (For example,
    /// 123456789012).
    target_id: ?[]const u8 = null,

    /// The entity type for which the assignment will be created.
    target_type: ProvisionTargetType,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .permission_set_arn = "PermissionSetArn",
        .target_id = "TargetId",
        .target_type = "TargetType",
    };
};

pub const ProvisionPermissionSetOutput = struct {
    /// The status object for the permission set provisioning operation.
    permission_set_provisioning_status: ?PermissionSetProvisioningStatus = null,

    pub const json_field_names = .{
        .permission_set_provisioning_status = "PermissionSetProvisioningStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ProvisionPermissionSetInput, options: CallOptions) !ProvisionPermissionSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ProvisionPermissionSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.ProvisionPermissionSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ProvisionPermissionSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ProvisionPermissionSetOutput, body, allocator);
}
