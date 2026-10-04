const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterAssociatedToSchedule = @import("cluster_associated_to_schedule.zig").ClusterAssociatedToSchedule;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const ModifySnapshotScheduleInput = struct {
    /// An updated list of schedule definitions. A schedule definition is made up of
    /// schedule
    /// expressions, for example, "cron(30 12 *)" or "rate(12 hours)".
    schedule_definitions: []const []const u8,

    /// A unique alphanumeric identifier of the schedule to modify.
    schedule_identifier: []const u8,
};

pub const ModifySnapshotScheduleOutput = @import("snapshot_schedule.zig").SnapshotSchedule;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifySnapshotScheduleInput, options: CallOptions) !ModifySnapshotScheduleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifySnapshotScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifySnapshotSchedule&Version=2012-12-01");
    for (input.schedule_definitions, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduleDefinitions.ScheduleDefinition.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    try body_buf.appendSlice(allocator, "&ScheduleIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.schedule_identifier);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifySnapshotScheduleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifySnapshotScheduleResult")) break;
            },
            else => {},
        }
    }

    var result: ModifySnapshotScheduleOutput = .{};
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
