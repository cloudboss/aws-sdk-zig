const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HookStatus = @import("hook_status.zig").HookStatus;
const ListHookResultsTargetType = @import("list_hook_results_target_type.zig").ListHookResultsTargetType;
const HookResultSummary = @import("hook_result_summary.zig").HookResultSummary;
const serde = @import("serde.zig");

pub const ListHookResultsInput = struct {
    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// Filters results by the status of Hook invocations. Can only be used in
    /// combination with
    /// `TypeArn`. Valid values are:
    ///
    /// * `HOOK_IN_PROGRESS`: The Hook is currently running.
    ///
    /// * `HOOK_COMPLETE_SUCCEEDED`: The Hook completed successfully.
    ///
    /// * `HOOK_COMPLETE_FAILED`: The Hook completed but failed validation.
    ///
    /// * `HOOK_FAILED`: The Hook encountered an error during execution.
    status: ?HookStatus = null,

    /// Filters results by the unique identifier of the target the Hook was invoked
    /// against.
    ///
    /// For change sets, this is the change set ARN. When the target is a Cloud
    /// Control API operation, this
    /// value must be the `HookRequestToken` returned by the Cloud Control API
    /// request. For more
    /// information on the `HookRequestToken`, see
    /// [ProgressEvent](https://docs.aws.amazon.com/cloudcontrolapi/latest/APIReference/API_ProgressEvent.html).
    ///
    /// Required when `TargetType` is specified and cannot be used otherwise.
    target_id: ?[]const u8 = null,

    /// Filters results by target type. Currently, only `CHANGE_SET` and
    /// `CLOUD_CONTROL` are supported filter options.
    ///
    /// Required when `TargetId` is specified and cannot be used otherwise.
    target_type: ?ListHookResultsTargetType = null,

    /// Filters results by the ARN of the Hook. Can be used alone or in combination
    /// with
    /// `Status`.
    type_arn: ?[]const u8 = null,
};

pub const ListHookResultsOutput = struct {
    /// A list of `HookResultSummary` structures that provides the status and Hook
    /// status reason for each Hook invocation for the specified target.
    hook_results: ?[]const HookResultSummary = null,

    /// Pagination token, `null` or empty if no more results.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the Hook invocation target.
    target_id: ?[]const u8 = null,

    /// The target type.
    target_type: ?ListHookResultsTargetType = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHookResultsInput, options: CallOptions) !ListHookResultsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHookResultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListHookResults&Version=2010-05-15");
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.status) |v| {
        try body_buf.appendSlice(allocator, "&Status=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.target_id) |v| {
        try body_buf.appendSlice(allocator, "&TargetId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.target_type) |v| {
        try body_buf.appendSlice(allocator, "&TargetType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.type_arn) |v| {
        try body_buf.appendSlice(allocator, "&TypeArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHookResultsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListHookResultsResult")) break;
            },
            else => {},
        }
    }

    var result: ListHookResultsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HookResults")) {
                    result.hook_results = try serde.deserializeHookResultSummaries(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetId")) {
                    result.target_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetType")) {
                    result.target_type = ListHookResultsTargetType.fromWireName(try reader.readElementText());
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
