const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ModifyHsmInput = struct {
    /// The new IP address for the elastic network interface (ENI) attached to the
    /// HSM.
    ///
    /// If the HSM is moved to a different subnet, and an IP address is not
    /// specified, an IP
    /// address will be randomly chosen from the CIDR range of the new subnet.
    eni_ip: ?[]const u8 = null,

    /// The new external ID.
    external_id: ?[]const u8 = null,

    /// The ARN of the HSM to modify.
    hsm_arn: []const u8,

    /// The new IAM role ARN.
    iam_role_arn: ?[]const u8 = null,

    /// The new identifier of the subnet that the HSM is in. The new subnet must be
    /// in the same
    /// Availability Zone as the current subnet.
    subnet_id: ?[]const u8 = null,

    /// The new IP address for the syslog monitoring server. The AWS CloudHSM
    /// service only supports
    /// one syslog monitoring server.
    syslog_ip: ?[]const u8 = null,

    pub const json_field_names = .{
        .eni_ip = "EniIp",
        .external_id = "ExternalId",
        .hsm_arn = "HsmArn",
        .iam_role_arn = "IamRoleArn",
        .subnet_id = "SubnetId",
        .syslog_ip = "SyslogIp",
    };
};

pub const ModifyHsmOutput = struct {
    /// The ARN of the HSM.
    hsm_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .hsm_arn = "HsmArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyHsmInput, options: CallOptions) !ModifyHsmOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyHsmInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudHsmFrontendService.ModifyHsm");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyHsmOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyHsmOutput, body, allocator);
}
