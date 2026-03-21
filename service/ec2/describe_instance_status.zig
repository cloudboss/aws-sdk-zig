const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const InstanceStatus = @import("instance_status.zig").InstanceStatus;
const serde = @import("serde.zig");

pub const DescribeInstanceStatusInput = struct {
    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The filters.
    ///
    /// * `availability-zone` - The Availability Zone of the instance.
    ///
    /// * `availability-zone-id` - The ID of the Availability Zone of the
    /// instance.
    ///
    /// * `event.code` - The code for the scheduled event
    /// (`instance-reboot` | `system-reboot` |
    /// `system-maintenance` | `instance-retirement` |
    /// `instance-stop`).
    ///
    /// * `event.description` - A description of the event.
    ///
    /// * `event.instance-event-id` - The ID of the event whose date and time
    /// you are modifying.
    ///
    /// * `event.not-after` - The latest end time for the scheduled event
    /// (for example, `2014-09-15T17:15:20.000Z`).
    ///
    /// * `event.not-before` - The earliest start time for the scheduled
    /// event (for example, `2014-09-15T17:15:20.000Z`).
    ///
    /// * `event.not-before-deadline` - The deadline for starting the event
    /// (for example, `2014-09-15T17:15:20.000Z`).
    ///
    /// * `instance-state-code` - The code for the instance state, as a
    /// 16-bit unsigned integer. The high byte is used for internal purposes and
    /// should
    /// be ignored. The low byte is set based on the state represented. The valid
    /// values
    /// are 0 (pending), 16 (running), 32 (shutting-down), 48 (terminated), 64
    /// (stopping), and 80 (stopped).
    ///
    /// * `instance-state-name` - The state of the instance
    /// (`pending` | `running` | `shutting-down` |
    /// `terminated` | `stopping` |
    /// `stopped`).
    ///
    /// * `instance-status.reachability` - Filters on instance status where
    /// the name is `reachability` (`passed` | `failed`
    /// | `initializing` | `insufficient-data`).
    ///
    /// * `instance-status.status` - The status of the instance
    /// (`ok` | `impaired` | `initializing` |
    /// `insufficient-data` | `not-applicable`).
    ///
    /// * `operator.managed` - A Boolean that indicates whether this is a
    /// managed instance.
    ///
    /// * `operator.principal` - The principal that manages the instance.
    /// Only valid for managed instances, where `managed` is
    /// `true`.
    ///
    /// * `system-status.reachability` - Filters on system status where the
    /// name is `reachability` (`passed` | `failed` |
    /// `initializing` | `insufficient-data`).
    ///
    /// * `system-status.status` - The system status of the instance
    /// (`ok` | `impaired` | `initializing` |
    /// `insufficient-data` | `not-applicable`).
    ///
    /// * `attached-ebs-status.status` - The status of the attached EBS volume
    /// for the instance (`ok` | `impaired` | `initializing` |
    /// `insufficient-data` | `not-applicable`).
    filters: ?[]const Filter = null,

    /// When `true`, includes the health status for all instances. When
    /// `false`, includes the health status for running instances only.
    ///
    /// Default: `false`
    include_all_instances: ?bool = null,

    /// The instance IDs.
    ///
    /// Default: Describes all your instances.
    ///
    /// Constraints: Maximum 100 explicitly specified instance IDs.
    instance_ids: ?[]const []const u8 = null,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    ///
    /// You cannot specify this parameter and the instance IDs parameter in the same
    /// request.
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,
};

pub const DescribeInstanceStatusOutput = struct {
    /// Information about the status of the instances.
    instance_statuses: ?[]const InstanceStatus = null,

    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there
    /// are no more items to return.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInstanceStatusInput, options: CallOptions) !DescribeInstanceStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInstanceStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeInstanceStatus&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.{d}.Name=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.{d}.Value.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.include_all_instances) |v| {
        try body_buf.appendSlice(allocator, "&IncludeAllInstances=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInstanceStatusOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeInstanceStatusOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instanceStatusSet")) {
                    result.instance_statuses = try serde.deserializeInstanceStatusList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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
