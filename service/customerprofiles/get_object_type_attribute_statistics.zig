const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GetObjectTypeAttributeStatisticsStats = @import("get_object_type_attribute_statistics_stats.zig").GetObjectTypeAttributeStatisticsStats;

pub const GetObjectTypeAttributeStatisticsInput = struct {
    /// The attribute name.
    attribute_name: []const u8,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// The unique name of the domain object type.
    object_type_name: []const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .domain_name = "DomainName",
        .object_type_name = "ObjectTypeName",
    };
};

pub const GetObjectTypeAttributeStatisticsOutput = struct {
    /// Time when this statistics was calculated.
    calculated_at: i64,

    /// The statistics.
    statistics: ?GetObjectTypeAttributeStatisticsStats = null,

    pub const json_field_names = .{
        .calculated_at = "CalculatedAt",
        .statistics = "Statistics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetObjectTypeAttributeStatisticsInput, options: CallOptions) !GetObjectTypeAttributeStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetObjectTypeAttributeStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/object-types/");
    try path_buf.appendSlice(allocator, input.object_type_name);
    try path_buf.appendSlice(allocator, "/attributes/");
    try path_buf.appendSlice(allocator, input.attribute_name);
    try path_buf.appendSlice(allocator, "/statistics");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetObjectTypeAttributeStatisticsOutput {
    var result: GetObjectTypeAttributeStatisticsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetObjectTypeAttributeStatisticsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
