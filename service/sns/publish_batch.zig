const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PublishBatchRequestEntry = @import("publish_batch_request_entry.zig").PublishBatchRequestEntry;
const BatchResultErrorEntry = @import("batch_result_error_entry.zig").BatchResultErrorEntry;
const PublishBatchResultEntry = @import("publish_batch_result_entry.zig").PublishBatchResultEntry;
const serde = @import("serde.zig");

pub const PublishBatchInput = struct {
    /// A list of `PublishBatch` request entries to be sent to the SNS
    /// topic.
    publish_batch_request_entries: []const PublishBatchRequestEntry,

    /// The Amazon resource name (ARN) of the topic you want to batch publish to.
    topic_arn: []const u8,
};

pub const PublishBatchOutput = struct {
    /// A list of failed `PublishBatch` responses.
    failed: ?[]const BatchResultErrorEntry = null,

    /// A list of successful `PublishBatch` responses.
    successful: ?[]const PublishBatchResultEntry = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishBatchInput, options: CallOptions) !PublishBatchOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishBatchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PublishBatch&Version=2010-03-31");
    for (input.publish_batch_request_entries, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PublishBatchRequestEntries.member.{d}.Id=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.id);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PublishBatchRequestEntries.member.{d}.Message=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.message);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.message_deduplication_id) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PublishBatchRequestEntries.member.{d}.MessageDeduplicationId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.message_group_id) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PublishBatchRequestEntries.member.{d}.MessageGroupId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.message_structure) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PublishBatchRequestEntries.member.{d}.MessageStructure=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.subject) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PublishBatchRequestEntries.member.{d}.Subject=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
    }
    try body_buf.appendSlice(allocator, "&TopicArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.topic_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishBatchOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PublishBatchResult")) break;
            },
            else => {},
        }
    }

    var result: PublishBatchOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Failed")) {
                    result.failed = try serde.deserializeBatchResultErrorEntryList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Successful")) {
                    result.successful = try serde.deserializePublishBatchResultEntryList(allocator, &reader, "member");
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
