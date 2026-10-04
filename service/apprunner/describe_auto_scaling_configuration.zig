const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoScalingConfiguration = @import("auto_scaling_configuration.zig").AutoScalingConfiguration;

pub const DescribeAutoScalingConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of the App Runner auto scaling configuration
    /// that you want a description for.
    ///
    /// The ARN can be a full auto scaling configuration ARN, or a partial ARN
    /// ending with either `.../*name*
    /// ` or
    /// `.../*name*/*revision*
    /// `. If a revision isn't specified, the latest active revision is
    /// described.
    auto_scaling_configuration_arn: []const u8,

    pub const json_field_names = .{
        .auto_scaling_configuration_arn = "AutoScalingConfigurationArn",
    };
};

pub const DescribeAutoScalingConfigurationOutput = struct {
    /// A full description of the App Runner auto scaling configuration that you
    /// specified in this request.
    auto_scaling_configuration: ?AutoScalingConfiguration = null,

    pub const json_field_names = .{
        .auto_scaling_configuration = "AutoScalingConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAutoScalingConfigurationInput, options: CallOptions) !DescribeAutoScalingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apprunner", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAutoScalingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apprunner", "AppRunner", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AppRunner.DescribeAutoScalingConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAutoScalingConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeAutoScalingConfigurationOutput, body, allocator);
}
