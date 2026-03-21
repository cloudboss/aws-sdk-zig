const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ReportInstanceReasonCodes = @import("report_instance_reason_codes.zig").ReportInstanceReasonCodes;
const ReportStatusType = @import("report_status_type.zig").ReportStatusType;
const serde = @import("serde.zig");

pub const ReportInstanceStatusInput = struct {
    /// Descriptive text about the health state of your instance.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The time at which the reported instance health state ended.
    end_time: ?i64 = null,

    /// The instances.
    instances: []const []const u8,

    /// The reason codes that describe the health state of your instance.
    ///
    /// * `instance-stuck-in-state`: My instance is stuck in a state.
    ///
    /// * `unresponsive`: My instance is unresponsive.
    ///
    /// * `not-accepting-credentials`: My instance is not accepting my
    /// credentials.
    ///
    /// * `password-not-available`: A password is not available for my
    /// instance.
    ///
    /// * `performance-network`: My instance is experiencing performance
    /// problems that I believe are network related.
    ///
    /// * `performance-instance-store`: My instance is experiencing performance
    /// problems that I believe are related to the instance stores.
    ///
    /// * `performance-ebs-volume`: My instance is experiencing performance
    /// problems that I believe are related to an EBS volume.
    ///
    /// * `performance-other`: My instance is experiencing performance
    /// problems.
    ///
    /// * `other`: [explain using the description parameter]
    reason_codes: []const ReportInstanceReasonCodes,

    /// The time at which the reported instance health state began.
    start_time: ?i64 = null,

    /// The status of all instances listed.
    status: ReportStatusType,
};

pub const ReportInstanceStatusOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReportInstanceStatusInput, options: CallOptions) !ReportInstanceStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ReportInstanceStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ReportInstanceStatus&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(allocator, "&EndTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    for (input.instances, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceId.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    for (input.reason_codes, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReasonCode.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
    }
    if (input.start_time) |v| {
        try body_buf.appendSlice(allocator, "&StartTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&Status=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.status.wireName());

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReportInstanceStatusOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: ReportInstanceStatusOutput = .{};

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
