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

pub const CreateUsageLimitInput = struct {
    /// The limit amount. If time-based, this amount is in minutes. If data-based,
    /// this amount is in terabytes (TB).
    /// The value must be a positive number.
    amount: i64,

    /// The action that Amazon Redshift takes when the limit is reached. The default
    /// is log.
    /// For more information about this parameter, see UsageLimit.
    breach_action: ?UsageLimitBreachAction = null,

    /// The identifier of the cluster that you want to limit usage.
    cluster_identifier: []const u8,

    /// The Amazon Redshift feature that you want to limit.
    feature_type: UsageLimitFeatureType,

    /// The type of limit. Depending on the feature type, this can be based on a
    /// time duration or data size.
    /// If `FeatureType` is `spectrum`, then `LimitType` must be `data-scanned`.
    /// If `FeatureType` is `concurrency-scaling`, then `LimitType` must be `time`.
    /// If `FeatureType` is `cross-region-datasharing`, then `LimitType` must be
    /// `data-scanned`.
    /// If `FeatureType` is `extra-compute-for-automatic-optimization`, then
    /// `LimitType` must be `time`.
    limit_type: UsageLimitLimitType,

    /// The time period that the amount applies to. A `weekly` period begins on
    /// Sunday. The default is `monthly`.
    period: ?UsageLimitPeriod = null,

    /// A list of tag instances.
    tags: ?[]const Tag = null,
};

pub const CreateUsageLimitOutput = @import("usage_limit.zig").UsageLimit;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUsageLimitInput, options: CallOptions) !CreateUsageLimitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUsageLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateUsageLimit&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&Amount=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.amount}) catch "");
    if (input.breach_action) |v| {
        try body_buf.appendSlice(allocator, "&BreachAction=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    try body_buf.appendSlice(allocator, "&FeatureType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.feature_type.wireName());
    try body_buf.appendSlice(allocator, "&LimitType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.limit_type.wireName());
    if (input.period) |v| {
        try body_buf.appendSlice(allocator, "&Period=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUsageLimitOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateUsageLimitResult")) break;
            },
            else => {},
        }
    }

    var result: CreateUsageLimitOutput = .{};
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
