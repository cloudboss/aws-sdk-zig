const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfigurationDetails = @import("encryption_configuration_details.zig").EncryptionConfigurationDetails;
const InstanceStatus = @import("instance_status.zig").InstanceStatus;

pub const DescribeInstanceInput = struct {
    /// The ARN of the instance of IAM Identity Center under which the operation
    /// will run.
    instance_arn: []const u8,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
    };
};

pub const DescribeInstanceOutput = struct {
    /// The date the instance was created.
    created_date: ?i64 = null,

    /// Contains the encryption configuration for your IAM Identity Center instance,
    /// including the encryption status, KMS key type, and KMS key ARN.
    encryption_configuration_details: ?EncryptionConfigurationDetails = null,

    /// The identifier of the identity store that is connected to the instance of
    /// IAM Identity Center.
    identity_store_id: ?[]const u8 = null,

    /// The ARN of the instance of IAM Identity Center under which the operation
    /// will run. For more information about ARNs, see [Amazon Resource Names (ARNs)
    /// and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: ?[]const u8 = null,

    /// Specifies the instance name.
    name: ?[]const u8 = null,

    /// The identifier of the Amazon Web Services account for which the instance was
    /// created.
    owner_account_id: ?[]const u8 = null,

    /// The status of the instance.
    status: ?InstanceStatus = null,

    /// Provides additional context about the current status of the IAM Identity
    /// Center instance. This field is particularly useful when an instance is in a
    /// non-ACTIVE state, such as CREATE_FAILED. When an instance fails to create or
    /// update, this field contains information about the cause, which may include
    /// issues with KMS key configuration, permission problems with the specified
    /// KMS key, or service-related errors.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_date = "CreatedDate",
        .encryption_configuration_details = "EncryptionConfigurationDetails",
        .identity_store_id = "IdentityStoreId",
        .instance_arn = "InstanceArn",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInstanceInput, options: CallOptions) !DescribeInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInstanceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.DescribeInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeInstanceOutput, body, allocator);
}
