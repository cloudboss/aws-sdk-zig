const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorResult = @import("error_result.zig").ErrorResult;

pub const BatchDisassociateAnalyticsDataSetInput = struct {
    /// An array of associated dataset identifiers to remove.
    data_set_ids: []const []const u8,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The identifier of the target account. Use to disassociate a dataset from a
    /// different account than the one containing
    /// the Connect Customer instance. If not specified, by default this value is
    /// the Amazon Web Services account that has the Connect Customer instance.
    target_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_set_ids = "DataSetIds",
        .instance_id = "InstanceId",
        .target_account_id = "TargetAccountId",
    };
};

pub const BatchDisassociateAnalyticsDataSetOutput = struct {
    /// An array of successfully disassociated dataset identifiers.
    deleted: ?[]const []const u8 = null,

    /// A list of errors for any datasets not successfully removed.
    errors: ?[]const ErrorResult = null,

    pub const json_field_names = .{
        .deleted = "Deleted",
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDisassociateAnalyticsDataSetInput, options: CallOptions) !BatchDisassociateAnalyticsDataSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDisassociateAnalyticsDataSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/analytics-data/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/associations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DataSetIds\":");
    try aws.json.writeValue(@TypeOf(input.data_set_ids), input.data_set_ids, allocator, &body_buf);
    has_prev = true;
    if (input.target_account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TargetAccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDisassociateAnalyticsDataSetOutput {
    const result: BatchDisassociateAnalyticsDataSetOutput = try aws.json.parseJsonObject(
        BatchDisassociateAnalyticsDataSetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
