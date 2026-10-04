const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetDistributionLatestCacheResetInput = struct {
    /// The name of the distribution for which to return the timestamp of the last
    /// cache
    /// reset.
    ///
    /// Use the `GetDistributions` action to get a list of distribution names that
    /// you
    /// can specify.
    ///
    /// When omitted, the response includes the latest cache reset timestamp of all
    /// your
    /// distributions.
    distribution_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .distribution_name = "distributionName",
    };
};

pub const GetDistributionLatestCacheResetOutput = struct {
    /// The timestamp of the last cache reset (`1479734909.17`) in Unix time
    /// format.
    create_time: ?i64 = null,

    /// The status of the last cache reset.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .create_time = "createTime",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDistributionLatestCacheResetInput, options: CallOptions) !GetDistributionLatestCacheResetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDistributionLatestCacheResetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.GetDistributionLatestCacheReset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDistributionLatestCacheResetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDistributionLatestCacheResetOutput, body, allocator);
}
