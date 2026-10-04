const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StackDriftDetectionStatus = @import("stack_drift_detection_status.zig").StackDriftDetectionStatus;
const StackDriftStatus = @import("stack_drift_status.zig").StackDriftStatus;

pub const DescribeStackDriftDetectionStatusInput = struct {
    /// The ID of the drift detection results of this operation.
    ///
    /// CloudFormation generates new results, with a new drift detection ID, each
    /// time this operation
    /// is run. However, the number of drift results CloudFormation retains for any
    /// given stack, and for
    /// how long, may vary.
    stack_drift_detection_id: []const u8,
};

pub const DescribeStackDriftDetectionStatusOutput = struct {
    /// The status of the stack drift detection operation.
    ///
    /// * `DETECTION_COMPLETE`: The stack drift detection operation has successfully
    /// completed for all resources in the stack that support drift detection.
    /// (Resources that
    /// don't currently support stack detection remain unchecked.)
    ///
    /// If you specified logical resource IDs for CloudFormation to use as a filter
    /// for the stack
    /// drift detection operation, only the resources with those logical IDs are
    /// checked for
    /// drift.
    ///
    /// * `DETECTION_FAILED`: The stack drift detection operation has failed for at
    /// least one resource in the stack. Results will be available for resources on
    /// which
    /// CloudFormation successfully completed drift detection.
    ///
    /// * `DETECTION_IN_PROGRESS`: The stack drift detection operation is currently
    /// in progress.
    detection_status: StackDriftDetectionStatus,

    /// The reason the stack drift detection operation has its current status.
    detection_status_reason: ?[]const u8 = null,

    /// Total number of stack resources that have drifted. This is NULL until the
    /// drift detection
    /// operation reaches a status of `DETECTION_COMPLETE`. This value will be 0 for
    /// stacks
    /// whose drift status is `IN_SYNC`.
    drifted_stack_resource_count: ?i32 = null,

    /// The ID of the drift detection results of this operation.
    ///
    /// CloudFormation generates new results, with a new drift detection ID, each
    /// time this operation
    /// is run. However, the number of reports CloudFormation retains for any given
    /// stack, and for how
    /// long, may vary.
    stack_drift_detection_id: []const u8,

    /// Status of the stack's actual configuration compared to its expected
    /// configuration.
    ///
    /// * `DRIFTED`: The stack differs from its expected template configuration. A
    /// stack is considered to have drifted if one or more of its resources have
    /// drifted.
    ///
    /// * `NOT_CHECKED`: CloudFormation hasn't checked if the stack differs from its
    /// expected template configuration.
    ///
    /// * `IN_SYNC`: The stack's actual configuration matches its expected template
    /// configuration.
    ///
    /// * `UNKNOWN`: CloudFormation could not run drift detection for a resource in
    ///   the
    /// stack. See the `DetectionStatusReason` for details.
    stack_drift_status: ?StackDriftStatus = null,

    /// The ID of the stack.
    stack_id: []const u8,

    /// Time at which the stack drift detection operation was initiated.
    timestamp: i64,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStackDriftDetectionStatusInput, options: CallOptions) !DescribeStackDriftDetectionStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStackDriftDetectionStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeStackDriftDetectionStatus&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&StackDriftDetectionId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_drift_detection_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStackDriftDetectionStatusOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeStackDriftDetectionStatusResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeStackDriftDetectionStatusOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DetectionStatus")) {
                    result.detection_status = StackDriftDetectionStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DetectionStatusReason")) {
                    result.detection_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftedStackResourceCount")) {
                    result.drifted_stack_resource_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StackDriftDetectionId")) {
                    result.stack_drift_detection_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackDriftStatus")) {
                    result.stack_drift_status = StackDriftStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
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
