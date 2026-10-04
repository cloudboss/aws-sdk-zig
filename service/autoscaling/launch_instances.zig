const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RetryStrategy = @import("retry_strategy.zig").RetryStrategy;
const LaunchInstancesError = @import("launch_instances_error.zig").LaunchInstancesError;
const InstanceCollection = @import("instance_collection.zig").InstanceCollection;
const serde = @import("serde.zig");

pub const LaunchInstancesInput = struct {
    /// The name of the Auto Scaling group to launch instances into.
    auto_scaling_group_name: []const u8,

    /// A list of Availability Zone IDs where instances should be launched. Must
    /// match or be included in the group's AZ configuration. You cannot specify
    /// both AvailabilityZones and AvailabilityZoneIds. Required for multi-AZ
    /// groups, optional for single-AZ groups.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The Availability Zones for the instance launch. Must match or be included in
    /// the Auto Scaling group's Availability Zone configuration. Either
    /// `AvailabilityZones` or `SubnetIds` must be specified for groups with
    /// multiple Availability Zone configurations.
    availability_zones: ?[]const []const u8 = null,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: []const u8,

    /// The number of instances to launch. Although this value can exceed 100 for
    /// instance weights, the actual instance count is limited to 100 instances per
    /// launch.
    requested_capacity: i32,

    /// Specifies whether to retry asynchronously if the synchronous launch fails.
    /// Valid values are NONE (default, no async retry) and
    /// RETRY_WITH_GROUP_CONFIGURATION (increase desired capacity and retry with
    /// group configuration).
    retry_strategy: ?RetryStrategy = null,

    /// The subnet IDs for the instance launch. Either `AvailabilityZones` or
    /// `SubnetIds` must be specified. If both are specified, the subnets must
    /// reside in the specified Availability Zones.
    subnet_ids: ?[]const []const u8 = null,
};

pub const LaunchInstancesOutput = struct {
    /// The name of the Auto Scaling group where the instances were launched.
    auto_scaling_group_name: ?[]const u8 = null,

    /// The idempotency token used for the request, either customer-specified or
    /// auto-generated.
    client_token: ?[]const u8 = null,

    /// A list of errors encountered during the launch attempt including details
    /// about failed instance launches with their corresponding error codes and
    /// messages.
    errors: ?[]const LaunchInstancesError = null,

    /// A list of successfully launched instances including details such as instance
    /// type, Availability Zone, subnet, lifecycle state, and instance IDs.
    instances: ?[]const InstanceCollection = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: LaunchInstancesInput, options: CallOptions) !LaunchInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: LaunchInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=LaunchInstances&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    if (input.availability_zone_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZoneIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.availability_zones) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZones.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    try body_buf.appendSlice(allocator, "&ClientToken=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.client_token);
    try body_buf.appendSlice(allocator, "&RequestedCapacity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.requested_capacity}) catch "");
    if (input.retry_strategy) |v| {
        try body_buf.appendSlice(allocator, "&RetryStrategy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.subnet_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !LaunchInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LaunchInstancesResult")) break;
            },
            else => {},
        }
    }

    var result: LaunchInstancesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClientToken")) {
                    result.client_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Errors")) {
                    result.errors = try serde.deserializeLaunchInstancesErrors(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Instances")) {
                    result.instances = try serde.deserializeInstanceCollections(allocator, &reader, "member");
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
