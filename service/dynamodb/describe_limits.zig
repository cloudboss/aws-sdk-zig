const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeLimitsInput = struct {
};

pub const DescribeLimitsOutput = struct {
    /// The maximum total read capacity units that your account allows you to
    /// provision across
    /// all of your tables in this Region.
    account_max_read_capacity_units: ?i64 = null,

    /// The maximum total write capacity units that your account allows you to
    /// provision
    /// across all of your tables in this Region.
    account_max_write_capacity_units: ?i64 = null,

    /// The maximum read capacity units that your account allows you to provision
    /// for a new
    /// table that you are creating in this Region, including the read capacity
    /// units
    /// provisioned for its global secondary indexes (GSIs).
    table_max_read_capacity_units: ?i64 = null,

    /// The maximum write capacity units that your account allows you to provision
    /// for a new
    /// table that you are creating in this Region, including the write capacity
    /// units
    /// provisioned for its global secondary indexes (GSIs).
    table_max_write_capacity_units: ?i64 = null,

    pub const json_field_names = .{
        .account_max_read_capacity_units = "AccountMaxReadCapacityUnits",
        .account_max_write_capacity_units = "AccountMaxWriteCapacityUnits",
        .table_max_read_capacity_units = "TableMaxReadCapacityUnits",
        .table_max_write_capacity_units = "TableMaxWriteCapacityUnits",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLimitsInput, options: CallOptions) !DescribeLimitsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLimitsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.DescribeLimits");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLimitsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLimitsOutput, body, allocator);
}
