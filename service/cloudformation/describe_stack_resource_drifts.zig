const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StackResourceDriftStatus = @import("stack_resource_drift_status.zig").StackResourceDriftStatus;
const StackResourceDrift = @import("stack_resource_drift.zig").StackResourceDrift;
const serde = @import("serde.zig");

pub const DescribeStackResourceDriftsInput = struct {
    /// The maximum number of results to be returned with a single call. If the
    /// number of
    /// available results exceeds this maximum, the response includes a `NextToken`
    /// value
    /// that you can assign to the `NextToken` request parameter to get the next set
    /// of
    /// results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The name of the stack for which you want drift information.
    stack_name: []const u8,

    /// The resource drift status values to use as filters for the resource drift
    /// results
    /// returned.
    ///
    /// * `DELETED`: The resource differs from its expected template configuration
    ///   in
    /// that the resource has been deleted.
    ///
    /// * `MODIFIED`: One or more resource properties differ from their expected
    /// template values.
    ///
    /// * `IN_SYNC`: The resource's actual configuration matches its expected
    /// template configuration.
    ///
    /// * `NOT_CHECKED`: CloudFormation doesn't currently return this value.
    ///
    /// * `UNKNOWN`: CloudFormation could not run drift detection for the
    /// resource.
    stack_resource_drift_status_filters: ?[]const StackResourceDriftStatus = null,
};

pub const DescribeStackResourceDriftsOutput = struct {
    /// If the request doesn't return all the remaining results, `NextToken` is set
    /// to
    /// a token. To retrieve the next set of results, call
    /// `DescribeStackResourceDrifts`
    /// again and assign that token to the request object's `NextToken` parameter.
    /// If the
    /// request returns all results, `NextToken` is set to `null`.
    next_token: ?[]const u8 = null,

    /// Drift information for the resources that have been checked for drift in the
    /// specified
    /// stack. This includes actual and expected configuration values for resources
    /// where CloudFormation
    /// detects drift.
    ///
    /// For a given stack, there will be one `StackResourceDrift` for each stack
    /// resource that has been checked for drift. Resources that haven't yet been
    /// checked for drift
    /// aren't included. Resources that do not currently support drift detection
    /// aren't checked, and
    /// so not included. For a list of resources that support drift detection, see
    /// [Resource
    /// type support for imports and drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html).
    stack_resource_drifts: ?[]const StackResourceDrift = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStackResourceDriftsInput, options: CallOptions) !DescribeStackResourceDriftsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStackResourceDriftsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeStackResourceDrifts&Version=2010-05-15");
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&StackName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_name);
    if (input.stack_resource_drift_status_filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StackResourceDriftStatusFilters.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStackResourceDriftsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeStackResourceDriftsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeStackResourceDriftsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackResourceDrifts")) {
                    result.stack_resource_drifts = try serde.deserializeStackResourceDrifts(allocator, &reader, "member");
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
