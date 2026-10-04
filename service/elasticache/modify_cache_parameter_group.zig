const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParameterNameValue = @import("parameter_name_value.zig").ParameterNameValue;
const serde = @import("serde.zig");

pub const ModifyCacheParameterGroupInput = struct {
    /// The name of the cache parameter group to modify.
    cache_parameter_group_name: []const u8,

    /// An array of parameter names and values for the parameter update. You must
    /// supply at
    /// least one parameter name and value; subsequent arguments are optional. A
    /// maximum of 20
    /// parameters may be modified per request.
    parameter_name_values: []const ParameterNameValue,
};

pub const ModifyCacheParameterGroupOutput = struct {
    /// The name of the cache parameter group.
    cache_parameter_group_name: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyCacheParameterGroupInput, options: CallOptions) !ModifyCacheParameterGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticache", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyCacheParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyCacheParameterGroup&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&CacheParameterGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cache_parameter_group_name);
    for (input.parameter_name_values, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.parameter_name) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ParameterNameValues.ParameterNameValue.{d}.ParameterName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.parameter_value) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ParameterNameValues.ParameterNameValue.{d}.ParameterValue=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyCacheParameterGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyCacheParameterGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyCacheParameterGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheParameterGroupName")) {
                    result.cache_parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
