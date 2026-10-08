const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AggregationStatusEnum = @import("aggregation_status_enum.zig").AggregationStatusEnum;
const HealthCheckPathRequestObject = @import("health_check_path_request_object.zig").HealthCheckPathRequestObject;
const IpScopeEnum = @import("ip_scope_enum.zig").IpScopeEnum;
const IpVersionEnum = @import("ip_version_enum.zig").IpVersionEnum;
const NetworkProtocolEnum = @import("network_protocol_enum.zig").NetworkProtocolEnum;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const ApplicationStatusCheckResponseObject = @import("application_status_check_response_object.zig").ApplicationStatusCheckResponseObject;
const serde = @import("serde.zig");

pub const CreateApplicationStatusCheckInput = struct {
    /// The aggregation setting for the application status check. When set to
    /// `included`, the result of this check contributes to the instance-level
    /// application status reported by `DescribeApplicationStatus`. When set to
    /// `excluded`, the check runs independently and does not affect the
    /// instance-level status. Valid values: `included` | `excluded`.
    aggregation: ?AggregationStatusEnum = null,

    /// A unique, case-sensitive identifier that you provide to ensure that the
    /// operation completes no more than one time. If you retry a request with the
    /// same token, the service ignores the request but does not return an error.
    /// For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The index of the network device to use for the health check. The value must
    /// be greater than or equal to 0.
    device_index: ?i32 = null,

    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The number of consecutive failed health checks before the application status
    /// is considered impaired. The value must be greater than 0.
    failure_threshold: ?i32 = null,

    /// The health check paths to use for the application status check. Health check
    /// paths define the network path from a source subnet to one or more
    /// destination subnets for cross-Availability Zone or Availability Zone to
    /// Local Zone health checking. If omitted, health checks are performed in the
    /// same subnet as the instance.
    health_check_paths: ?[]const HealthCheckPathRequestObject = null,

    /// The number of seconds to wait before starting health checks after an
    /// instance is launched. Valid values: 1 to 600.
    initialization_grace_period_seconds: ?i32 = null,

    /// The interval, in seconds, between health checks. Valid value: 60.
    interval: ?i32 = null,

    /// The IP scope to use for the health check. Valid value: `private`.
    ip_scope: ?IpScopeEnum = null,

    /// The IP version to use for the health check. Valid values: `ipv4` and `ipv6`.
    ip_version: ?IpVersionEnum = null,

    /// The URL path to use for the health check HTTP request (for example,
    /// `/health` or `/status`).
    path: ?[]const u8 = null,

    /// The port to use for the health check. Valid values: 1 to 65535.
    port: i32,

    /// The protocol to use for the health check. Valid values: `http` | `https`.
    protocol: NetworkProtocolEnum,

    /// The HTTP status codes that indicate a successful health check response.
    /// Specify a comma-separated list of individual status codes or ranges, for
    /// example, `200,202,300-399`. For a range, the first value must be less than
    /// the second value. Maximum length: 64 characters. Default: `200`.
    status_code_matcher: ?[]const u8 = null,

    /// The number of consecutive successful health checks before the application
    /// status is considered healthy. The value must be greater than 0.
    success_threshold: ?i32 = null,

    /// The tags to apply to the application status check.
    tag_specifications: ?[]const TagSpecification = null,

    /// The amount of time, in seconds, to wait for a health check response before
    /// considering it failed. Valid values: 1 to 30. The value must be less than
    /// `Interval`.
    timeout: ?i32 = null,
};

pub const CreateApplicationStatusCheckOutput = struct {
    /// Information about the application status check.
    application_status_check: ?ApplicationStatusCheckResponseObject = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationStatusCheckInput, options: CallOptions) !CreateApplicationStatusCheckOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationStatusCheckInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateApplicationStatusCheck&Version=2016-11-15");
    if (input.aggregation) |v| {
        try body_buf.appendSlice(allocator, "&Aggregation=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.device_index) |v| {
        try body_buf.appendSlice(allocator, "&DeviceIndex=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.failure_threshold) |v| {
        try body_buf.appendSlice(allocator, "&FailureThreshold=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.health_check_paths) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.destinations) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.security_group_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&HealthCheckPath.{d}.Destination.{d}.SecurityGroupId=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.subnet_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&HealthCheckPath.{d}.Destination.{d}.SubnetId=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
            if (item.source) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.security_group_id) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&HealthCheckPath.{d}.Source.SecurityGroupId=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.subnet_id) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&HealthCheckPath.{d}.Source.SubnetId=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
        }
    }
    if (input.initialization_grace_period_seconds) |v| {
        try body_buf.appendSlice(allocator, "&InitializationGracePeriodSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.interval) |v| {
        try body_buf.appendSlice(allocator, "&Interval=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ip_scope) |v| {
        try body_buf.appendSlice(allocator, "&IpScope=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.ip_version) |v| {
        try body_buf.appendSlice(allocator, "&IpVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.path) |v| {
        try body_buf.appendSlice(allocator, "&Path=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&Port=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.port}) catch "");
    try body_buf.appendSlice(allocator, "&Protocol=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.protocol.wireName());
    if (input.status_code_matcher) |v| {
        try body_buf.appendSlice(allocator, "&StatusCodeMatcher=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.success_threshold) |v| {
        try body_buf.appendSlice(allocator, "&SuccessThreshold=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.key) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.timeout) |v| {
        try body_buf.appendSlice(allocator, "&Timeout=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationStatusCheckOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateApplicationStatusCheckOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "applicationStatusCheck")) {
                    result.application_status_check = try serde.deserializeApplicationStatusCheckResponseObject(allocator, &reader);
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
