const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingGroupMetadata = @import("billing_group_metadata.zig").BillingGroupMetadata;
const BillingGroupProperties = @import("billing_group_properties.zig").BillingGroupProperties;

pub const DescribeBillingGroupInput = struct {
    /// The name of the billing group.
    billing_group_name: []const u8,

    pub const json_field_names = .{
        .billing_group_name = "billingGroupName",
    };
};

pub const DescribeBillingGroupOutput = struct {
    /// The ARN of the billing group.
    billing_group_arn: ?[]const u8 = null,

    /// The ID of the billing group.
    billing_group_id: ?[]const u8 = null,

    /// Additional information about the billing group.
    billing_group_metadata: ?BillingGroupMetadata = null,

    /// The name of the billing group.
    billing_group_name: ?[]const u8 = null,

    /// The properties of the billing group.
    billing_group_properties: ?BillingGroupProperties = null,

    /// The version of the billing group.
    version: ?i64 = null,

    pub const json_field_names = .{
        .billing_group_arn = "billingGroupArn",
        .billing_group_id = "billingGroupId",
        .billing_group_metadata = "billingGroupMetadata",
        .billing_group_name = "billingGroupName",
        .billing_group_properties = "billingGroupProperties",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBillingGroupInput, options: CallOptions) !DescribeBillingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBillingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/billing-groups/");
    try path_buf.appendSlice(allocator, input.billing_group_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBillingGroupOutput {
    var result: DescribeBillingGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeBillingGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
