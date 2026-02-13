const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CancelSpotFleetRequestsSuccessItem = @import("cancel_spot_fleet_requests_success_item.zig").CancelSpotFleetRequestsSuccessItem;
const CancelSpotFleetRequestsErrorItem = @import("cancel_spot_fleet_requests_error_item.zig").CancelSpotFleetRequestsErrorItem;
const serde = @import("serde.zig");

/// Cancels the specified Spot Fleet requests.
///
/// After you cancel a Spot Fleet request, the Spot Fleet launches no new
/// instances.
///
/// You must also specify whether a canceled Spot Fleet request should terminate
/// its instances. If you
/// choose to terminate the instances, the Spot Fleet request enters the
/// `cancelled_terminating` state. Otherwise, the Spot Fleet request enters
/// the `cancelled_running` state and the instances continue to run until they
/// are interrupted or you terminate them manually.
///
/// **Important:**
///
/// **Terminating an instance is permanent and irreversible.**
///
/// After you terminate an instance, you can no longer connect to it, and it
/// can't be recovered.
/// All attached Amazon EBS volumes that are configured to be deleted on
/// termination are also permanently
/// deleted and can't be recovered. All data stored on instance store volumes is
/// permanently lost.
/// For more information, see [
/// How instance termination
/// works](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/how-ec2-instance-termination-works.html).
///
/// Before you terminate an instance, ensure that you have backed up all data
/// that you need to
/// retain after the termination to persistent storage.
///
/// **Restrictions**
///
/// * You can delete up to 100 fleets in a single request. If you exceed the
///   specified
/// number, no fleets are deleted.
pub const CancelSpotFleetRequestsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IDs of the Spot Fleet requests.
    ///
    /// Constraint: You can specify up to 100 IDs in a single request.
    spot_fleet_request_ids: []const []const u8,

    /// Indicates whether to terminate the associated instances when the Spot Fleet
    /// request is canceled.
    /// The default is to terminate the instances.
    ///
    /// To let the instances continue to run after the Spot Fleet request is
    /// canceled, specify
    /// `no-terminate-instances`.
    terminate_instances: bool,
};

pub const CancelSpotFleetRequestsOutput = struct {
    /// Information about the Spot Fleet requests that are successfully canceled.
    successful_fleet_requests: ?[]const CancelSpotFleetRequestsSuccessItem = null,

    /// Information about the Spot Fleet requests that are not successfully
    /// canceled.
    unsuccessful_fleet_requests: ?[]const CancelSpotFleetRequestsErrorItem = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CancelSpotFleetRequestsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CancelSpotFleetRequestsInput, options: Options) !CancelSpotFleetRequestsOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CancelSpotFleetRequestsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CancelSpotFleetRequests&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    for (input.spot_fleet_request_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestIds.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
    }
    try body_buf.appendSlice(alloc, "&TerminateInstances=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, if (input.terminate_instances) "true" else "false");

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CancelSpotFleetRequestsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CancelSpotFleetRequestsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "successfulFleetRequestSet")) {
                    result.successful_fleet_requests = try serde.deserializeCancelSpotFleetRequestsSuccessSet(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "unsuccessfulFleetRequestSet")) {
                    result.unsuccessful_fleet_requests = try serde.deserializeCancelSpotFleetRequestsErrorSet(&reader, alloc, "item");
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
