const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ClusterAssociatedToSchedule = @import("cluster_associated_to_schedule.zig").ClusterAssociatedToSchedule;
const serde = @import("serde.zig");

pub const CreateSnapshotScheduleInput = struct {
    dry_run: ?bool = null,

    next_invocations: ?i32 = null,

    /// The definition of the snapshot schedule. The definition is made up of
    /// schedule
    /// expressions, for example "cron(30 12 *)" or "rate(12 hours)".
    schedule_definitions: ?[]const []const u8 = null,

    /// The description of the snapshot schedule.
    schedule_description: ?[]const u8 = null,

    /// A unique identifier for a snapshot schedule. Only alphanumeric characters
    /// are allowed
    /// for the identifier.
    schedule_identifier: ?[]const u8 = null,

    /// An optional set of tags you can use to search for the schedule.
    tags: ?[]const Tag = null,
};

pub const CreateSnapshotScheduleOutput = @import("snapshot_schedule.zig").SnapshotSchedule;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSnapshotScheduleInput, options: CallOptions) !CreateSnapshotScheduleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSnapshotScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateSnapshotSchedule&Version=2012-12-01");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.next_invocations) |v| {
        try body_buf.appendSlice(allocator, "&NextInvocations=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.schedule_definitions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduleDefinitions.ScheduleDefinition.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.schedule_description) |v| {
        try body_buf.appendSlice(allocator, "&ScheduleDescription=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.schedule_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ScheduleIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSnapshotScheduleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateSnapshotScheduleResult")) break;
            },
            else => {},
        }
    }

    var result: CreateSnapshotScheduleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssociatedClusterCount")) {
                    result.associated_cluster_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AssociatedClusters")) {
                    result.associated_clusters = try serde.deserializeAssociatedClusterList(allocator, &reader, "ClusterAssociatedToSchedule");
                } else if (std.mem.eql(u8, e.local, "NextInvocations")) {
                    result.next_invocations = try serde.deserializeScheduledSnapshotTimeList(allocator, &reader, "SnapshotTime");
                } else if (std.mem.eql(u8, e.local, "ScheduleDefinitions")) {
                    result.schedule_definitions = try serde.deserializeScheduleDefinitionList(allocator, &reader, "ScheduleDefinition");
                } else if (std.mem.eql(u8, e.local, "ScheduleDescription")) {
                    result.schedule_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduleIdentifier")) {
                    result.schedule_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try serde.deserializeTagList(allocator, &reader, "Tag");
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
