const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DestinationOptionsRequest = @import("destination_options_request.zig").DestinationOptionsRequest;
const LogDestinationType = @import("log_destination_type.zig").LogDestinationType;
const FlowLogsResourceType = @import("flow_logs_resource_type.zig").FlowLogsResourceType;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TrafficType = @import("traffic_type.zig").TrafficType;
const UnsuccessfulItem = @import("unsuccessful_item.zig").UnsuccessfulItem;
const serde = @import("serde.zig");

pub const CreateFlowLogsInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request. For more information, see [How to ensure
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// The ARN of the IAM role that allows Amazon EC2 to publish flow logs across
    /// accounts.
    deliver_cross_account_role: ?[]const u8 = null,

    /// The ARN of the IAM role that allows Amazon EC2 to publish flow logs to the
    /// log destination.
    ///
    /// This parameter is required if the destination type is `cloud-watch-logs`,
    /// or if the destination type is `kinesis-data-firehose` and the delivery
    /// stream
    /// and the resources to monitor are in different accounts.
    deliver_logs_permission_arn: ?[]const u8 = null,

    /// The destination options.
    destination_options: ?DestinationOptionsRequest = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The destination for the flow log data. The meaning of this parameter depends
    /// on the destination type.
    ///
    /// * If the destination type is `cloud-watch-logs`, specify the ARN of a
    ///   CloudWatch Logs log group. For example:
    ///
    /// arn:aws:logs:*region*:*account_id*:log-group:*my_group*
    ///
    /// Alternatively, use the `LogGroupName` parameter.
    ///
    /// * If the destination type is `s3`, specify the ARN of an S3 bucket. For
    ///   example:
    ///
    /// arn:aws:s3:::*my_bucket*/*my_subfolder*/
    ///
    /// The subfolder is optional. Note that you can't use `AWSLogs` as a subfolder
    /// name.
    ///
    /// * If the destination type is `kinesis-data-firehose`, specify the ARN of a
    ///   Kinesis Data Firehose delivery stream. For example:
    ///
    /// arn:aws:firehose:*region*:*account_id*:deliverystream:*my_stream*
    log_destination: ?[]const u8 = null,

    /// The type of destination for the flow log data.
    ///
    /// Default: `cloud-watch-logs`
    log_destination_type: ?LogDestinationType = null,

    /// The fields to include in the flow log record. List the fields in the order
    /// in which
    /// they should appear. If you omit this parameter, the flow log is created
    /// using the
    /// default format. If you specify this parameter, you must include at least one
    /// field. For more information about the available fields, see [Flow log
    /// records](https://docs.aws.amazon.com/vpc/latest/userguide/flow-log-records.html)
    /// in the *Amazon VPC User Guide* or [Transit Gateway Flow Log
    /// records](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-flow-logs.html#flow-log-records) in the *Amazon Web Services Transit Gateway Guide*.
    ///
    /// Specify the fields using the `${field-id}` format, separated by spaces.
    log_format: ?[]const u8 = null,

    /// The name of a new or existing CloudWatch Logs log group where Amazon EC2
    /// publishes your flow logs.
    ///
    /// This parameter is valid only if the destination type is `cloud-watch-logs`.
    log_group_name: ?[]const u8 = null,

    /// The maximum interval of time during which a flow of packets is captured and
    /// aggregated into a flow log record.
    /// The possible values are 60 seconds (1 minute) or 600 seconds (10 minutes).
    /// This parameter must be 60 seconds for transit gateway resource types.
    ///
    /// When a network interface is attached to a [Nitro-based
    /// instance](https://docs.aws.amazon.com/ec2/latest/instancetypes/ec2-nitro-instances.html), the aggregation interval is always 60 seconds or less, regardless
    /// of the value that you specify.
    ///
    /// Default: 600
    max_aggregation_interval: ?i32 = null,

    /// The IDs of the resources to monitor. For example, if the resource type is
    /// `VPC`, specify the IDs of the VPCs.
    ///
    /// Constraints: Maximum of 25 for transit gateway resource types. Maximum of
    /// 1000 for the
    /// other resource types.
    resource_ids: []const []const u8,

    /// The type of resource to monitor.
    resource_type: FlowLogsResourceType,

    /// The tags to apply to the flow logs.
    tag_specifications: ?[]const TagSpecification = null,

    /// The type of traffic to monitor (accepted traffic, rejected traffic, or all
    /// traffic).
    /// This parameter is not supported for transit gateway resource types. It is
    /// required for
    /// the other resource types.
    traffic_type: ?TrafficType = null,
};

pub const CreateFlowLogsOutput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request.
    client_token: ?[]const u8 = null,

    /// The IDs of the flow logs.
    flow_log_ids: ?[]const []const u8 = null,

    /// Information about the flow logs that could not be created successfully.
    unsuccessful: ?[]const UnsuccessfulItem = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFlowLogsInput, options: CallOptions) !CreateFlowLogsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFlowLogsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateFlowLogs&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.deliver_cross_account_role) |v| {
        try body_buf.appendSlice(allocator, "&DeliverCrossAccountRole=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.deliver_logs_permission_arn) |v| {
        try body_buf.appendSlice(allocator, "&DeliverLogsPermissionArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destination_options) |v| {
        if (v.file_format) |sv| {
            try body_buf.appendSlice(allocator, "&DestinationOptions.FileFormat=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.hive_compatible_partitions) |sv| {
            try body_buf.appendSlice(allocator, "&DestinationOptions.HiveCompatiblePartitions=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.per_hour_partition) |sv| {
            try body_buf.appendSlice(allocator, "&DestinationOptions.PerHourPartition=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.log_destination) |v| {
        try body_buf.appendSlice(allocator, "&LogDestination=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.log_destination_type) |v| {
        try body_buf.appendSlice(allocator, "&LogDestinationType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.log_format) |v| {
        try body_buf.appendSlice(allocator, "&LogFormat=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.log_group_name) |v| {
        try body_buf.appendSlice(allocator, "&LogGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_aggregation_interval) |v| {
        try body_buf.appendSlice(allocator, "&MaxAggregationInterval=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    for (input.resource_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourceId.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    try body_buf.appendSlice(allocator, "&ResourceType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.resource_type.wireName());
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
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.traffic_type) |v| {
        try body_buf.appendSlice(allocator, "&TrafficType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFlowLogsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateFlowLogsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "clientToken")) {
                    result.client_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "flowLogIdSet")) {
                    result.flow_log_ids = try serde.deserializeValueStringList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "unsuccessful")) {
                    result.unsuccessful = try serde.deserializeUnsuccessfulItemSet(allocator, &reader, "item");
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
