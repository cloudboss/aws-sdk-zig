const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegionStatus = @import("region_status.zig").RegionStatus;

pub const RemoveRegionInput = struct {
    /// The Amazon Resource Name (ARN) of the IAM Identity Center instance.
    instance_arn: []const u8,

    /// The name of the Amazon Web Services Region to remove from the IAM Identity
    /// Center instance. The Region name must be 1-32 characters long and follow the
    /// pattern of Amazon Web Services Region names (for example, us-east-1). The
    /// primary Region cannot be removed.
    region_name: []const u8,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .region_name = "RegionName",
    };
};

pub const RemoveRegionOutput = struct {
    /// The status of the Region after the remove operation. The status is REMOVING
    /// when the asynchronous workflow is in progress. The Region record is deleted
    /// when the workflow completes.
    status: ?RegionStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemoveRegionInput, options: CallOptions) !RemoveRegionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RemoveRegionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.RemoveRegion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemoveRegionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RemoveRegionOutput, body, allocator);
}
