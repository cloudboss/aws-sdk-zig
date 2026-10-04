const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeSummary = @import("change_summary.zig").ChangeSummary;
const FailureCode = @import("failure_code.zig").FailureCode;
const Intent = @import("intent.zig").Intent;
const ChangeStatus = @import("change_status.zig").ChangeStatus;

pub const DescribeChangeSetInput = struct {
    /// Required. The catalog related to the request. Fixed value:
    /// `AWSMarketplace`
    catalog: []const u8,

    /// Required. The unique identifier for the `StartChangeSet` request that you
    /// want to describe the details for.
    change_set_id: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .change_set_id = "ChangeSetId",
    };
};

pub const DescribeChangeSetOutput = struct {
    /// An array of `ChangeSummary` objects.
    change_set: ?[]const ChangeSummary = null,

    /// The ARN associated with the unique identifier for the change set referenced
    /// in this
    /// request.
    change_set_arn: ?[]const u8 = null,

    /// Required. The unique identifier for the change set referenced in this
    /// request.
    change_set_id: ?[]const u8 = null,

    /// The optional name provided in the `StartChangeSet` request. If you do not
    /// provide a name, one is set by default.
    change_set_name: ?[]const u8 = null,

    /// The date and time, in ISO 8601 format (2018-02-27T13:45:22Z), the request
    /// transitioned
    /// to a terminal state. The change cannot transition to a different state. Null
    /// if the
    /// request is not in a terminal state.
    end_time: ?[]const u8 = null,

    /// Returned if the change set is in `FAILED` status. Can be either
    /// `CLIENT_ERROR`, which means that there are issues with the request (see
    /// the `ErrorDetailList`), or `SERVER_FAULT`, which means that there
    /// is a problem in the system, and you should retry your request.
    failure_code: ?FailureCode = null,

    /// Returned if there is a failure on the change set, but that failure is not
    /// related to
    /// any of the changes in the request.
    failure_description: ?[]const u8 = null,

    /// The optional intent provided in the `StartChangeSet` request. If you do not
    /// provide an intent, `APPLY` is set by default.
    intent: ?Intent = null,

    /// The date and time, in ISO 8601 format (2018-02-27T13:45:22Z), the request
    /// started.
    start_time: ?[]const u8 = null,

    /// The status of the change request.
    status: ?ChangeStatus = null,

    pub const json_field_names = .{
        .change_set = "ChangeSet",
        .change_set_arn = "ChangeSetArn",
        .change_set_id = "ChangeSetId",
        .change_set_name = "ChangeSetName",
        .end_time = "EndTime",
        .failure_code = "FailureCode",
        .failure_description = "FailureDescription",
        .intent = "Intent",
        .start_time = "StartTime",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeChangeSetInput, options: CallOptions) !DescribeChangeSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeChangeSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("catalog.marketplace", "Marketplace Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DescribeChangeSet";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "catalog=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.catalog);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "changeSetId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.change_set_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeChangeSetOutput {
    var result: DescribeChangeSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeChangeSetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
