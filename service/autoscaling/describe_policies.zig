const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScalingPolicy = @import("scaling_policy.zig").ScalingPolicy;
const serde = @import("serde.zig");

pub const DescribePoliciesInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: ?[]const u8 = null,

    /// The maximum number of items to be returned with each call. The default value
    /// is
    /// `50` and the maximum value is `100`.
    max_records: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a
    /// previous call.)
    next_token: ?[]const u8 = null,

    /// The names of one or more policies. If you omit this property, all policies
    /// are
    /// described. If a group name is provided, the results are limited to that
    /// group. If you
    /// specify an unknown policy name, it is ignored with no error.
    ///
    /// Array Members: Maximum number of 50 items.
    policy_names: ?[]const []const u8 = null,

    /// One or more policy types. The valid values are `SimpleScaling`,
    /// `StepScaling`, `TargetTrackingScaling`, and
    /// `PredictiveScaling`.
    policy_types: ?[]const []const u8 = null,
};

pub const DescribePoliciesOutput = struct {
    /// A string that indicates that the response contains more items than can be
    /// returned in
    /// a single response. To receive additional items, specify this string for the
    /// `NextToken` value when requesting the next set of items. This value is
    /// null when there are no more items to return.
    next_token: ?[]const u8 = null,

    /// The scaling policies.
    scaling_policies: ?[]const ScalingPolicy = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePoliciesInput, options: CallOptions) !DescribePoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribePolicies&Version=2011-01-01");
    if (input.auto_scaling_group_name) |v| {
        try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.policy_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyNames.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.policy_types) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyTypes.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePoliciesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribePoliciesResult")) break;
            },
            else => {},
        }
    }

    var result: DescribePoliciesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScalingPolicies")) {
                    result.scaling_policies = try serde.deserializeScalingPolicies(allocator, &reader, "member");
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
