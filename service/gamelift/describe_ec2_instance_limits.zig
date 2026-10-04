const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EC2InstanceType = @import("ec2_instance_type.zig").EC2InstanceType;
const EC2InstanceLimit = @import("ec2_instance_limit.zig").EC2InstanceLimit;

pub const DescribeEC2InstanceLimitsInput = struct {
    /// Name of an Amazon EC2 instance type that is supported in Amazon GameLift
    /// Servers. A fleet instance type
    /// determines the computing resources of each instance in the fleet, including
    /// CPU, memory,
    /// storage, and networking capacity. Do not specify a value for this parameter
    /// to retrieve
    /// limits for all instance types.
    ec2_instance_type: ?EC2InstanceType = null,

    /// The name of a remote location to request instance limits for, in the form of
    /// an Amazon Web Services
    /// Region code such as `us-west-2`.
    location: ?[]const u8 = null,

    pub const json_field_names = .{
        .ec2_instance_type = "EC2InstanceType",
        .location = "Location",
    };
};

pub const DescribeEC2InstanceLimitsOutput = struct {
    /// The maximum number of instances for the specified instance type.
    ec2_instance_limits: ?[]const EC2InstanceLimit = null,

    pub const json_field_names = .{
        .ec2_instance_limits = "EC2InstanceLimits",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEC2InstanceLimitsInput, options: CallOptions) !DescribeEC2InstanceLimitsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEC2InstanceLimitsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.DescribeEC2InstanceLimits");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEC2InstanceLimitsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEC2InstanceLimitsOutput, body, allocator);
}
