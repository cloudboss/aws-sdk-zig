const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateAnalyticsDataSetInput = struct {
    /// The identifier of the dataset to associate with the target account.
    data_set_id: []const u8,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The identifier of the target account. Use to associate a dataset to a
    /// different account than the one containing
    /// the Amazon Connect instance. If not specified, by default this value is the
    /// Amazon Web Services account that has the Amazon Connect instance.
    target_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
        .instance_id = "InstanceId",
        .target_account_id = "TargetAccountId",
    };
};

pub const AssociateAnalyticsDataSetOutput = struct {
    /// The identifier of the dataset that was associated.
    data_set_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Resource Access Manager share.
    resource_share_arn: ?[]const u8 = null,

    /// The Resource Access Manager share ID that is generated.
    resource_share_id: ?[]const u8 = null,

    /// The identifier of the target account.
    target_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
        .resource_share_arn = "ResourceShareArn",
        .resource_share_id = "ResourceShareId",
        .target_account_id = "TargetAccountId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateAnalyticsDataSetInput, options: CallOptions) !AssociateAnalyticsDataSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateAnalyticsDataSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/analytics-data/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/association");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DataSetId\":");
    try aws.json.writeValue(@TypeOf(input.data_set_id), input.data_set_id, allocator, &body_buf);
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateAnalyticsDataSetOutput {
    var result: AssociateAnalyticsDataSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociateAnalyticsDataSetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
