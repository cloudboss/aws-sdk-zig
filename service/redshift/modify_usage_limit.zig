const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UsageLimitBreachAction = @import("usage_limit_breach_action.zig").UsageLimitBreachAction;
const UsageLimitFeatureType = @import("usage_limit_feature_type.zig").UsageLimitFeatureType;
const UsageLimitLimitType = @import("usage_limit_limit_type.zig").UsageLimitLimitType;
const UsageLimitPeriod = @import("usage_limit_period.zig").UsageLimitPeriod;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const ModifyUsageLimitInput = struct {
    /// The new limit amount.
    /// For more information about this parameter, see UsageLimit.
    amount: ?i64 = null,

    /// The new action that Amazon Redshift takes when the limit is reached.
    /// For more information about this parameter, see UsageLimit.
    breach_action: ?UsageLimitBreachAction = null,

    /// The identifier of the usage limit to modify.
    usage_limit_id: []const u8,
};

pub const ModifyUsageLimitOutput = @import("usage_limit.zig").UsageLimit;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyUsageLimitInput, options: CallOptions) !ModifyUsageLimitOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyUsageLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyUsageLimit&Version=2012-12-01");
    if (input.amount) |v| {
        try body_buf.appendSlice(allocator, "&Amount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.breach_action) |v| {
        try body_buf.appendSlice(allocator, "&BreachAction=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&UsageLimitId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.usage_limit_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyUsageLimitOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyUsageLimitResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyUsageLimitOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Amount")) {
                    result.amount = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BreachAction")) {
                    result.breach_action = UsageLimitBreachAction.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FeatureType")) {
                    result.feature_type = UsageLimitFeatureType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LimitType")) {
                    result.limit_type = UsageLimitLimitType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = UsageLimitPeriod.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try serde.deserializeTagList(allocator, &reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "UsageLimitId")) {
                    result.usage_limit_id = try allocator.dupe(u8, try reader.readElementText());
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
