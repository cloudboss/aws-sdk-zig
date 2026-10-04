const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GatewayCapacity = @import("gateway_capacity.zig").GatewayCapacity;

pub const UpdateGatewayInformationInput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon CloudWatch log group that you
    /// want to use
    /// to monitor and log events in the gateway.
    ///
    /// For more information, see [What is Amazon CloudWatch
    /// Logs?](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html)
    cloud_watch_log_group_arn: ?[]const u8 = null,

    gateway_arn: []const u8,

    /// Specifies the size of the gateway's metadata cache. This setting impacts
    /// gateway
    /// performance and hardware recommendations. For more information, see
    /// [Performance guidance for gateways with multiple file
    /// shares](https://docs.aws.amazon.com/filegateway/latest/files3/performance-multiple-file-shares.html)
    /// in the *Amazon S3 File Gateway User Guide*.
    gateway_capacity: ?GatewayCapacity = null,

    gateway_name: ?[]const u8 = null,

    /// A value that indicates the time zone of the gateway.
    gateway_timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_log_group_arn = "CloudWatchLogGroupARN",
        .gateway_arn = "GatewayARN",
        .gateway_capacity = "GatewayCapacity",
        .gateway_name = "GatewayName",
        .gateway_timezone = "GatewayTimezone",
    };
};

pub const UpdateGatewayInformationOutput = struct {
    gateway_arn: ?[]const u8 = null,

    /// The name you configured for your gateway.
    gateway_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .gateway_name = "GatewayName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGatewayInformationInput, options: CallOptions) !UpdateGatewayInformationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGatewayInformationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.UpdateGatewayInformation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGatewayInformationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGatewayInformationOutput, body, allocator);
}
