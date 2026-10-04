const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceNetworkLogType = @import("service_network_log_type.zig").ServiceNetworkLogType;

pub const GetAccessLogSubscriptionInput = struct {
    /// The ID or ARN of the access log subscription.
    access_log_subscription_identifier: []const u8,

    pub const json_field_names = .{
        .access_log_subscription_identifier = "accessLogSubscriptionIdentifier",
    };
};

pub const GetAccessLogSubscriptionOutput = struct {
    /// The Amazon Resource Name (ARN) of the access log subscription.
    arn: []const u8,

    /// The date and time that the access log subscription was created, in ISO-8601
    /// format.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the access log destination.
    destination_arn: []const u8,

    /// The ID of the access log subscription.
    id: []const u8,

    /// The date and time that the access log subscription was last updated, in
    /// ISO-8601 format.
    last_updated_at: i64,

    /// The Amazon Resource Name (ARN) of the service network or service.
    resource_arn: []const u8,

    /// The ID of the service network or service.
    resource_id: []const u8,

    /// The log type for the service network.
    service_network_log_type: ?ServiceNetworkLogType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .destination_arn = "destinationArn",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .resource_arn = "resourceArn",
        .resource_id = "resourceId",
        .service_network_log_type = "serviceNetworkLogType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccessLogSubscriptionInput, options: CallOptions) !GetAccessLogSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccessLogSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accesslogsubscriptions/");
    try path_buf.appendSlice(allocator, input.access_log_subscription_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccessLogSubscriptionOutput {
    const result: GetAccessLogSubscriptionOutput = try aws.json.parseJsonObject(
        GetAccessLogSubscriptionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
