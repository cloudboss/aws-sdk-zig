const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionType = @import("subscription_type.zig").SubscriptionType;

pub const CreateHsmInput = struct {
    /// A user-defined token to ensure idempotence. Subsequent calls to this
    /// operation with the
    /// same token will be ignored.
    client_token: ?[]const u8 = null,

    /// The IP address to assign to the HSM's ENI.
    ///
    /// If an IP address is not specified, an IP address will be randomly chosen
    /// from the CIDR
    /// range of the subnet.
    eni_ip: ?[]const u8 = null,

    /// The external ID from `IamRoleArn`, if present.
    external_id: ?[]const u8 = null,

    /// The ARN of an IAM role to enable the AWS CloudHSM service to allocate an ENI
    /// on your
    /// behalf.
    iam_role_arn: []const u8,

    /// The SSH public key to install on the HSM.
    ssh_key: []const u8,

    /// The identifier of the subnet in your VPC in which to place the HSM.
    subnet_id: []const u8,

    subscription_type: SubscriptionType,

    /// The IP address for the syslog monitoring server. The AWS CloudHSM service
    /// only supports one
    /// syslog monitoring server.
    syslog_ip: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .eni_ip = "EniIp",
        .external_id = "ExternalId",
        .iam_role_arn = "IamRoleArn",
        .ssh_key = "SshKey",
        .subnet_id = "SubnetId",
        .subscription_type = "SubscriptionType",
        .syslog_ip = "SyslogIp",
    };
};

pub const CreateHsmOutput = struct {
    /// The ARN of the HSM.
    hsm_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .hsm_arn = "HsmArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHsmInput, options: CallOptions) !CreateHsmOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudhsm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHsmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsm", "CloudHSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudHsmFrontendService.CreateHsm");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHsmOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateHsmOutput, body, allocator);
}
