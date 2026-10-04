const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduledActionType = @import("scheduled_action_type.zig").ScheduledActionType;
const ScheduledActionState = @import("scheduled_action_state.zig").ScheduledActionState;
const serde = @import("serde.zig");

pub const CreateScheduledActionInput = struct {
    /// If true, the schedule is enabled. If false, the scheduled action does not
    /// trigger.
    /// For more information about `state` of the scheduled action, see
    /// ScheduledAction.
    enable: ?bool = null,

    /// The end time in UTC of the scheduled action. After this time, the scheduled
    /// action does not trigger.
    /// For more information about this parameter, see ScheduledAction.
    end_time: ?i64 = null,

    /// The IAM role to assume to run the target action.
    /// For more information about this parameter, see ScheduledAction.
    iam_role: []const u8,

    /// The schedule in `at( )` or `cron( )` format.
    /// For more information about this parameter, see ScheduledAction.
    schedule: []const u8,

    /// The description of the scheduled action.
    scheduled_action_description: ?[]const u8 = null,

    /// The name of the scheduled action. The name must be unique within an account.
    /// For more information about this parameter, see ScheduledAction.
    scheduled_action_name: []const u8,

    /// The start time in UTC of the scheduled action.
    /// Before this time, the scheduled action does not trigger.
    /// For more information about this parameter, see ScheduledAction.
    start_time: ?i64 = null,

    /// A JSON format string of the Amazon Redshift API operation with input
    /// parameters.
    /// For more information about this parameter, see ScheduledAction.
    target_action: ScheduledActionType,
};

pub const CreateScheduledActionOutput = @import("scheduled_action.zig").ScheduledAction;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScheduledActionInput, options: CallOptions) !CreateScheduledActionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScheduledActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateScheduledAction&Version=2012-12-01");
    if (input.enable) |v| {
        try body_buf.appendSlice(allocator, "&Enable=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(allocator, "&EndTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&IamRole=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.iam_role);
    try body_buf.appendSlice(allocator, "&Schedule=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.schedule);
    if (input.scheduled_action_description) |v| {
        try body_buf.appendSlice(allocator, "&ScheduledActionDescription=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ScheduledActionName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.scheduled_action_name);
    if (input.start_time) |v| {
        try body_buf.appendSlice(allocator, "&StartTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.target_action.pause_cluster) |sv| {
        try body_buf.appendSlice(allocator, "&TargetAction.PauseCluster.ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.cluster_identifier);
    }
    if (input.target_action.resize_cluster) |sv| {
        if (sv.classic) |sv2| {
            try body_buf.appendSlice(allocator, "&TargetAction.ResizeCluster.Classic=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        try body_buf.appendSlice(allocator, "&TargetAction.ResizeCluster.ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.cluster_identifier);
        if (sv.cluster_type) |sv2| {
            try body_buf.appendSlice(allocator, "&TargetAction.ResizeCluster.ClusterType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.node_type) |sv2| {
            try body_buf.appendSlice(allocator, "&TargetAction.ResizeCluster.NodeType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.number_of_nodes) |sv2| {
            try body_buf.appendSlice(allocator, "&TargetAction.ResizeCluster.NumberOfNodes=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        if (sv.reserved_node_id) |sv2| {
            try body_buf.appendSlice(allocator, "&TargetAction.ResizeCluster.ReservedNodeId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.target_reserved_node_offering_id) |sv2| {
            try body_buf.appendSlice(allocator, "&TargetAction.ResizeCluster.TargetReservedNodeOfferingId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.target_action.resume_cluster) |sv| {
        try body_buf.appendSlice(allocator, "&TargetAction.ResumeCluster.ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.cluster_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScheduledActionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateScheduledActionResult")) break;
            },
            else => {},
        }
    }

    var result: CreateScheduledActionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "IamRole")) {
                    result.iam_role = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextInvocations")) {
                    result.next_invocations = try serde.deserializeScheduledActionTimeList(allocator, &reader, "ScheduledActionTime");
                } else if (std.mem.eql(u8, e.local, "Schedule")) {
                    result.schedule = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActionDescription")) {
                    result.scheduled_action_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActionName")) {
                    result.scheduled_action_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = ScheduledActionState.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetAction")) {
                    result.target_action = try serde.deserializeScheduledActionType(allocator, &reader);
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
