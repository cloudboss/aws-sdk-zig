const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventBridgeConfiguration = @import("event_bridge_configuration.zig").EventBridgeConfiguration;
const LambdaFunctionConfiguration = @import("lambda_function_configuration.zig").LambdaFunctionConfiguration;
const QueueConfiguration = @import("queue_configuration.zig").QueueConfiguration;
const TopicConfiguration = @import("topic_configuration.zig").TopicConfiguration;
const serde = @import("serde.zig");

pub const GetBucketNotificationConfigurationInput = struct {
    /// The name of the bucket for which to get the notification configuration.
    ///
    /// When you use this API operation with an access point, provide the alias of
    /// the access point in place of the bucket name.
    ///
    /// When you use this API operation with an Object Lambda access point, provide
    /// the alias of the Object Lambda access point in place of the bucket name.
    /// If the Object Lambda access point alias in a request is not valid, the error
    /// code `InvalidAccessPointAliasError` is returned.
    /// For more information about `InvalidAccessPointAliasError`, see [List of
    /// Error
    /// Codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#ErrorCodeList).
    bucket: []const u8,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,
};

pub const GetBucketNotificationConfigurationOutput = @import("notification_configuration.zig").NotificationConfiguration;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBucketNotificationConfigurationInput, options: CallOptions) !GetBucketNotificationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBucketNotificationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "notification");
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
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBucketNotificationConfigurationOutput {
    var result: GetBucketNotificationConfigurationOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var lambda_function_configurations_list: std.ArrayList(LambdaFunctionConfiguration) = .empty;
    var queue_configurations_list: std.ArrayList(QueueConfiguration) = .empty;
    var topic_configurations_list: std.ArrayList(TopicConfiguration) = .empty;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventBridgeConfiguration")) {
                    result.event_bridge_configuration = try serde.deserializeEventBridgeConfiguration(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "CloudFunctionConfiguration")) {
                    try lambda_function_configurations_list.append(allocator, try serde.deserializeLambdaFunctionConfiguration(allocator, &reader));
                } else if (std.mem.eql(u8, e.local, "QueueConfiguration")) {
                    try queue_configurations_list.append(allocator, try serde.deserializeQueueConfiguration(allocator, &reader));
                } else if (std.mem.eql(u8, e.local, "TopicConfiguration")) {
                    try topic_configurations_list.append(allocator, try serde.deserializeTopicConfiguration(allocator, &reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    result.lambda_function_configurations = if (lambda_function_configurations_list.items.len > 0) try lambda_function_configurations_list.toOwnedSlice(allocator) else null;
    result.queue_configurations = if (queue_configurations_list.items.len > 0) try queue_configurations_list.toOwnedSlice(allocator) else null;
    result.topic_configurations = if (topic_configurations_list.items.len > 0) try topic_configurations_list.toOwnedSlice(allocator) else null;
    _ = headers;

    return result;
}
