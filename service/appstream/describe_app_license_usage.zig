const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdminAppLicenseUsageRecord = @import("admin_app_license_usage_record.zig").AdminAppLicenseUsageRecord;

pub const DescribeAppLicenseUsageInput = struct {
    /// Billing period for the usage record.
    ///
    /// Specify the value in *yyyy-mm* format. For example, for August
    /// 2025, use *2025-08*.
    billing_period: []const u8,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// Token for pagination of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_period = "BillingPeriod",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeAppLicenseUsageOutput = struct {
    /// Collection of license usage records.
    app_license_usages: ?[]const AdminAppLicenseUsageRecord = null,

    /// Token for pagination of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_license_usages = "AppLicenseUsages",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAppLicenseUsageInput, options: CallOptions) !DescribeAppLicenseUsageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAppLicenseUsageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.DescribeAppLicenseUsage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAppLicenseUsageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAppLicenseUsageOutput, body, allocator);
}
