const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeRange = @import("time_range.zig").TimeRange;
const AttackSummary = @import("attack_summary.zig").AttackSummary;

pub const ListAttacksInput = struct {
    /// The end of the time period for the attacks. This is a `timestamp` type. The
    /// request syntax listing for this call indicates a `number` type,
    /// but you can provide the time in any valid [timestamp
    /// format](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-types.html#parameter-type-timestamp) setting.
    end_time: ?TimeRange = null,

    /// The greatest number of objects that you want Shield Advanced to return to
    /// the list request. Shield Advanced might return fewer objects
    /// than you indicate in this setting, even if more objects are available. If
    /// there are more objects remaining, Shield Advanced will always also return a
    /// `NextToken` value
    /// in the response.
    ///
    /// The default setting is 20.
    max_results: ?i32 = null,

    /// When you request a list of objects from Shield Advanced, if the response
    /// does not include all of the remaining available objects,
    /// Shield Advanced includes a `NextToken` value in the response. You can
    /// retrieve the next batch of objects by requesting the list again and
    /// providing the token that was returned by the prior call in your request.
    ///
    /// You can indicate the maximum number of objects that you want Shield Advanced
    /// to return for a single call with the `MaxResults`
    /// setting. Shield Advanced will not return more than `MaxResults` objects, but
    /// may return fewer, even if more objects are still available.
    ///
    /// Whenever more objects remain that Shield Advanced has not yet returned to
    /// you, the response will include a `NextToken` value.
    ///
    /// On your first call to a list operation, leave this setting empty.
    next_token: ?[]const u8 = null,

    /// The ARNs (Amazon Resource Names) of the resources that were attacked. If you
    /// leave this
    /// blank, all applicable resources for this account will be included.
    resource_arns: ?[]const []const u8 = null,

    /// The start of the time period for the attacks. This is a `timestamp` type.
    /// The request syntax listing for this call indicates a `number` type,
    /// but you can provide the time in any valid [timestamp
    /// format](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-types.html#parameter-type-timestamp) setting.
    start_time: ?TimeRange = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_arns = "ResourceArns",
        .start_time = "StartTime",
    };
};

pub const ListAttacksOutput = struct {
    /// The attack information for the specified time range.
    attack_summaries: ?[]const AttackSummary = null,

    /// When you request a list of objects from Shield Advanced, if the response
    /// does not include all of the remaining available objects,
    /// Shield Advanced includes a `NextToken` value in the response. You can
    /// retrieve the next batch of objects by requesting the list again and
    /// providing the token that was returned by the prior call in your request.
    ///
    /// You can indicate the maximum number of objects that you want Shield Advanced
    /// to return for a single call with the `MaxResults`
    /// setting. Shield Advanced will not return more than `MaxResults` objects, but
    /// may return fewer, even if more objects are still available.
    ///
    /// Whenever more objects remain that Shield Advanced has not yet returned to
    /// you, the response will include a `NextToken` value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attack_summaries = "AttackSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAttacksInput, options: CallOptions) !ListAttacksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "shield", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAttacksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("shield", "Shield", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.ListAttacks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAttacksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAttacksOutput, body, allocator);
}
