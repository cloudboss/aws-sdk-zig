const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountAssignmentOperationStatus = @import("account_assignment_operation_status.zig").AccountAssignmentOperationStatus;

pub const DescribeAccountAssignmentCreationStatusInput = struct {
    /// The identifier that is used to track the request operation progress.
    account_assignment_creation_request_id: []const u8,

    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed. For more information about ARNs, see [Amazon Resource Names
    /// (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: []const u8,

    pub const json_field_names = .{
        .account_assignment_creation_request_id = "AccountAssignmentCreationRequestId",
        .instance_arn = "InstanceArn",
    };
};

pub const DescribeAccountAssignmentCreationStatusOutput = struct {
    /// The status object for the account assignment creation operation.
    account_assignment_creation_status: ?AccountAssignmentOperationStatus = null,

    pub const json_field_names = .{
        .account_assignment_creation_status = "AccountAssignmentCreationStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccountAssignmentCreationStatusInput, options: CallOptions) !DescribeAccountAssignmentCreationStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccountAssignmentCreationStatusInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.DescribeAccountAssignmentCreationStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccountAssignmentCreationStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAccountAssignmentCreationStatusOutput, body, allocator);
}
