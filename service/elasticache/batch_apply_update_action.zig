const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProcessedUpdateAction = @import("processed_update_action.zig").ProcessedUpdateAction;
const UnprocessedUpdateAction = @import("unprocessed_update_action.zig").UnprocessedUpdateAction;
const serde = @import("serde.zig");

pub const BatchApplyUpdateActionInput = struct {
    /// The cache cluster IDs
    cache_cluster_ids: ?[]const []const u8 = null,

    /// The replication group IDs
    replication_group_ids: ?[]const []const u8 = null,

    /// The unique ID of the service update
    service_update_name: []const u8,
};

pub const BatchApplyUpdateActionOutput = struct {
    /// Update actions that have been processed successfully
    processed_update_actions: ?[]const ProcessedUpdateAction = null,

    /// Update actions that haven't been processed successfully
    unprocessed_update_actions: ?[]const UnprocessedUpdateAction = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchApplyUpdateActionInput, options: CallOptions) !BatchApplyUpdateActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticache", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchApplyUpdateActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=BatchApplyUpdateAction&Version=2015-02-02");
    if (input.cache_cluster_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CacheClusterIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.replication_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReplicationGroupIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    try body_buf.appendSlice(allocator, "&ServiceUpdateName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.service_update_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchApplyUpdateActionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BatchApplyUpdateActionResult")) break;
            },
            else => {},
        }
    }

    var result: BatchApplyUpdateActionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ProcessedUpdateActions")) {
                    result.processed_update_actions = try serde.deserializeProcessedUpdateActionList(allocator, &reader, "ProcessedUpdateAction");
                } else if (std.mem.eql(u8, e.local, "UnprocessedUpdateActions")) {
                    result.unprocessed_update_actions = try serde.deserializeUnprocessedUpdateActionList(allocator, &reader, "UnprocessedUpdateAction");
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
