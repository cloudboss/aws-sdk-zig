const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrincipalType = @import("principal_type.zig").PrincipalType;
const TargetType = @import("target_type.zig").TargetType;
const AccountAssignmentOperationStatus = @import("account_assignment_operation_status.zig").AccountAssignmentOperationStatus;

pub const DeleteAccountAssignmentInput = struct {
    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed. For more information about ARNs, see [Amazon Resource Names
    /// (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: []const u8,

    /// The ARN of the permission set that will be used to remove access.
    permission_set_arn: []const u8,

    /// An identifier for an object in IAM Identity Center, such as a user or group.
    /// PrincipalIds are GUIDs (For example, f81d4fae-7dec-11d0-a765-00a0c91e6bf6).
    /// For more information about PrincipalIds in IAM Identity Center, see the [IAM
    /// Identity Center Identity Store API
    /// Reference](/singlesignon/latest/IdentityStoreAPIReference/welcome.html).
    principal_id: []const u8,

    /// The entity type for which the assignment will be deleted.
    principal_type: PrincipalType,

    /// TargetID is an Amazon Web Services account identifier, (For example,
    /// 123456789012).
    target_id: []const u8,

    /// The entity type for which the assignment will be deleted.
    target_type: TargetType,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .permission_set_arn = "PermissionSetArn",
        .principal_id = "PrincipalId",
        .principal_type = "PrincipalType",
        .target_id = "TargetId",
        .target_type = "TargetType",
    };
};

pub const DeleteAccountAssignmentOutput = struct {
    /// The status object for the account assignment deletion operation.
    account_assignment_deletion_status: ?AccountAssignmentOperationStatus = null,

    pub const json_field_names = .{
        .account_assignment_deletion_status = "AccountAssignmentDeletionStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAccountAssignmentInput, options: CallOptions) !DeleteAccountAssignmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAccountAssignmentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.DeleteAccountAssignment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAccountAssignmentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteAccountAssignmentOutput, body, allocator);
}
