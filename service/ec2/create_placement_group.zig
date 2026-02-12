const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SpreadLevel = @import("spread_level.zig").SpreadLevel;
const PlacementStrategy = @import("placement_strategy.zig").PlacementStrategy;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const PlacementGroup = @import("placement_group.zig").PlacementGroup;
const serde = @import("serde.zig");

/// Creates a placement group in which to launch instances. The strategy of the
/// placement
/// group determines how the instances are organized within the group.
///
/// A `cluster` placement group is a logical grouping of instances within a
/// single Availability Zone that benefit from low network latency, high network
/// throughput.
/// A `spread` placement group places instances on distinct hardware. A
/// `partition` placement group places groups of instances in different
/// partitions, where instances in one partition do not share the same hardware
/// with
/// instances in another partition.
///
/// For more information, see [Placement
/// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html) in the
/// *Amazon EC2 User Guide*.
pub const CreatePlacementGroupInput = struct {
    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// A name for the placement group. Must be unique within the scope of your
    /// account for
    /// the Region.
    ///
    /// Constraints: Up to 255 ASCII characters
    group_name: ?[]const u8 = null,

    /// Reserved for future use.
    linked_group_id: ?[]const u8 = null,

    /// The number of partitions. Valid only when **Strategy** is
    /// set to `partition`.
    partition_count: ?i32 = null,

    /// Determines how placement groups spread instances.
    ///
    /// * Host – You can use `host` only with Outpost placement
    /// groups.
    ///
    /// * Rack – No usage restrictions.
    spread_level: ?SpreadLevel = null,

    /// The placement strategy.
    strategy: ?PlacementStrategy = null,

    /// The tags to apply to the new placement group.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreatePlacementGroupOutput = struct {
    /// Information about the placement group.
    placement_group: ?PlacementGroup = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreatePlacementGroupOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreatePlacementGroupInput, options: Options) !CreatePlacementGroupOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreatePlacementGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreatePlacementGroup&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.group_name) |v| {
        try body_buf.appendSlice(alloc, "&GroupName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.linked_group_id) |v| {
        try body_buf.appendSlice(alloc, "&LinkedGroupId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.partition_count) |v| {
        try body_buf.appendSlice(alloc, "&PartitionCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.spread_level) |v| {
        try body_buf.appendSlice(alloc, "&SpreadLevel=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.strategy) |v| {
        try body_buf.appendSlice(alloc, "&Strategy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreatePlacementGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreatePlacementGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "placementGroup")) {
                    result.placement_group = try serde.deserializePlacementGroup(&reader, alloc);
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
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
