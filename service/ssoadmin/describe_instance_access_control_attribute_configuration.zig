const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceAccessControlAttributeConfiguration = @import("instance_access_control_attribute_configuration.zig").InstanceAccessControlAttributeConfiguration;
const InstanceAccessControlAttributeConfigurationStatus = @import("instance_access_control_attribute_configuration_status.zig").InstanceAccessControlAttributeConfigurationStatus;

pub const DescribeInstanceAccessControlAttributeConfigurationInput = struct {
    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed.
    instance_arn: []const u8,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
    };
};

pub const DescribeInstanceAccessControlAttributeConfigurationOutput = struct {
    /// Gets the list of IAM Identity Center identity store attributes that have
    /// been added to your ABAC configuration.
    instance_access_control_attribute_configuration: ?InstanceAccessControlAttributeConfiguration = null,

    /// The status of the attribute configuration process.
    status: ?InstanceAccessControlAttributeConfigurationStatus = null,

    /// Provides more details about the current status of the specified attribute.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_access_control_attribute_configuration = "InstanceAccessControlAttributeConfiguration",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInstanceAccessControlAttributeConfigurationInput, options: CallOptions) !DescribeInstanceAccessControlAttributeConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInstanceAccessControlAttributeConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.DescribeInstanceAccessControlAttributeConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInstanceAccessControlAttributeConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeInstanceAccessControlAttributeConfigurationOutput, body, allocator);
}
