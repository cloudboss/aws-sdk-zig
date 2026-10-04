const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TopicRefreshSchedule = @import("topic_refresh_schedule.zig").TopicRefreshSchedule;

pub const DescribeTopicRefreshScheduleInput = struct {
    /// The Amazon Web Services account ID.
    aws_account_id: []const u8,

    /// The ID of the dataset.
    dataset_id: []const u8,

    /// The ID of the topic that contains the refresh schedule that you want to
    /// describe. This
    /// ID is unique per Amazon Web Services Region for each Amazon Web Services
    /// account.
    topic_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dataset_id = "DatasetId",
        .topic_id = "TopicId",
    };
};

pub const DescribeTopicRefreshScheduleOutput = struct {
    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: ?[]const u8 = null,

    /// The definition of a refresh schedule.
    refresh_schedule: ?TopicRefreshSchedule = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the topic.
    topic_arn: ?[]const u8 = null,

    /// The ID of the topic that contains the refresh schedule that you want to
    /// describe. This
    /// ID is unique per Amazon Web Services Region for each Amazon Web Services
    /// account.
    topic_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
        .refresh_schedule = "RefreshSchedule",
        .request_id = "RequestId",
        .status = "Status",
        .topic_arn = "TopicArn",
        .topic_id = "TopicId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTopicRefreshScheduleInput, options: CallOptions) !DescribeTopicRefreshScheduleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTopicRefreshScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/topics/");
    try path_buf.appendSlice(allocator, input.topic_id);
    try path_buf.appendSlice(allocator, "/schedules/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTopicRefreshScheduleOutput {
    var result: DescribeTopicRefreshScheduleOutput = try aws.json.parseJsonObject(
        DescribeTopicRefreshScheduleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
