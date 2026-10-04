const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CallAs = @import("call_as.zig").CallAs;
const StackResourceDriftStatus = @import("stack_resource_drift_status.zig").StackResourceDriftStatus;
const StackInstanceResourceDriftsSummary = @import("stack_instance_resource_drifts_summary.zig").StackInstanceResourceDriftsSummary;
const serde = @import("serde.zig");

pub const ListStackInstanceResourceDriftsInput = struct {
    /// [Service-managed permissions] Specifies whether you are acting as an account
    /// administrator
    /// in the organization's management account or as a delegated administrator in
    /// a
    /// member account.
    ///
    /// By default, `SELF` is specified. Use `SELF` for StackSets with
    /// self-managed permissions.
    ///
    /// * If you are signed in to the management account, specify
    /// `SELF`.
    ///
    /// * If you are signed in to a delegated administrator account, specify
    /// `DELEGATED_ADMIN`.
    ///
    /// Your Amazon Web Services account must be registered as a delegated
    /// administrator in the management account. For more information, see [Register
    /// a
    /// delegated
    /// administrator](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-delegated-admin.html) in the *CloudFormation User Guide*.
    call_as: ?CallAs = null,

    /// The maximum number of results to be returned with a single call. If the
    /// number of
    /// available results exceeds this maximum, the response includes a `NextToken`
    /// value
    /// that you can assign to the `NextToken` request parameter to get the next set
    /// of
    /// results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous call.)
    next_token: ?[]const u8 = null,

    /// The unique ID of the drift operation.
    operation_id: []const u8,

    /// The name of the Amazon Web Services account that you want to list resource
    /// drifts for.
    stack_instance_account: []const u8,

    /// The name of the Region where you want to list resource drifts.
    stack_instance_region: []const u8,

    /// The resource drift status of the stack instance.
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
    stack_instance_resource_drift_statuses: ?[]const StackResourceDriftStatus = null,

    /// The name or unique ID of the StackSet that you want to list drifted
    /// resources for.
    stack_set_name: []const u8,
};

pub const ListStackInstanceResourceDriftsOutput = struct {
    /// If the previous paginated request didn't return all of the remaining
    /// results, the response
    /// object's `NextToken` parameter value is set to a token. To retrieve the next
    /// set of
    /// results, call this action again and assign that token to the request
    /// object's
    /// `NextToken` parameter. If there are no remaining results, the previous
    /// response
    /// object's `NextToken` parameter is set to `null`.
    next_token: ?[]const u8 = null,

    /// A list of `StackInstanceResourceDriftsSummary` structures that contain
    /// information about the specified stack instances.
    summaries: ?[]const StackInstanceResourceDriftsSummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStackInstanceResourceDriftsInput, options: CallOptions) !ListStackInstanceResourceDriftsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStackInstanceResourceDriftsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListStackInstanceResourceDrifts&Version=2010-05-15");
    if (input.call_as) |v| {
        try body_buf.appendSlice(allocator, "&CallAs=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&OperationId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.operation_id);
    try body_buf.appendSlice(allocator, "&StackInstanceAccount=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_instance_account);
    try body_buf.appendSlice(allocator, "&StackInstanceRegion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_instance_region);
    if (input.stack_instance_resource_drift_statuses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StackInstanceResourceDriftStatuses.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    try body_buf.appendSlice(allocator, "&StackSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_set_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStackInstanceResourceDriftsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListStackInstanceResourceDriftsResult")) break;
            },
            else => {},
        }
    }

    var result: ListStackInstanceResourceDriftsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Summaries")) {
                    result.summaries = try serde.deserializeStackInstanceResourceDriftsSummaries(allocator, &reader, "member");
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
