const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Affinity = @import("affinity.zig").Affinity;
const HostTenancy = @import("host_tenancy.zig").HostTenancy;

/// Modifies the placement attributes for a specified instance. You can do the
/// following:
///
/// * Modify the affinity between an instance and a [Dedicated
/// Host](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-overview.html). When affinity is set to `host` and the instance is
/// not associated with a specific Dedicated Host, the next time the instance is
/// started, it is automatically associated with the host on which it lands. If
/// the
/// instance is restarted or rebooted, this relationship persists.
///
/// * Change the Dedicated Host with which an instance is associated.
///
/// * Change the instance tenancy of an instance.
///
/// * Move an instance to or from a [placement
/// group](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html).
///
/// At least one attribute for affinity, host ID, tenancy, or placement group
/// name must be
/// specified in the request. Affinity and tenancy can be modified in the same
/// request.
///
/// To modify the host ID, tenancy, placement group, or partition for an
/// instance, the
/// instance must be in the `stopped` state.
pub const ModifyInstancePlacementInput = struct {
    /// The affinity setting for the instance. For more information, see [Host
    /// affinity](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/how-dedicated-hosts-work.html#dedicated-hosts-affinity) in the *Amazon EC2 User Guide*.
    affinity: ?Affinity = null,

    /// The Group Id of a placement group. You must specify the Placement Group
    /// **Group Id** to launch an instance in a shared placement
    /// group.
    group_id: ?[]const u8 = null,

    /// The name of the placement group in which to place the instance. For spread
    /// placement
    /// groups, the instance must have a tenancy of `default`. For cluster and
    /// partition placement groups, the instance must have a tenancy of `default` or
    /// `dedicated`.
    ///
    /// To remove an instance from a placement group, specify an empty string ("").
    group_name: ?[]const u8 = null,

    /// The ID of the Dedicated Host with which to associate the instance.
    host_id: ?[]const u8 = null,

    /// The ARN of the host resource group in which to place the instance. The
    /// instance must
    /// have a tenancy of `host` to specify this parameter.
    host_resource_group_arn: ?[]const u8 = null,

    /// The ID of the instance that you are modifying.
    instance_id: []const u8,

    /// The number of the partition in which to place the instance. Valid only if
    /// the
    /// placement group strategy is set to `partition`.
    partition_number: ?i32 = null,

    /// The tenancy for the instance.
    ///
    /// **Note:**
    ///
    /// For T3 instances, you must launch the instance on a Dedicated Host to use a
    /// tenancy of `host`. You can't change the tenancy from
    /// `host` to `dedicated` or `default`.
    /// Attempting to make one of these unsupported tenancy changes results in an
    /// `InvalidRequest` error code.
    tenancy: ?HostTenancy = null,
};

pub const ModifyInstancePlacementOutput = struct {
    /// Is `true` if the request succeeds, and an error otherwise.
    @"return": ?bool = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyInstancePlacementOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyInstancePlacementInput, options: Options) !ModifyInstancePlacementOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyInstancePlacementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyInstancePlacement&Version=2016-11-15");
    if (input.affinity) |v| {
        try body_buf.appendSlice(alloc, "&Affinity=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.group_id) |v| {
        try body_buf.appendSlice(alloc, "&GroupId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.group_name) |v| {
        try body_buf.appendSlice(alloc, "&GroupName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.host_id) |v| {
        try body_buf.appendSlice(alloc, "&HostId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.host_resource_group_arn) |v| {
        try body_buf.appendSlice(alloc, "&HostResourceGroupArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try appendUrlEncoded(alloc, &body_buf, input.instance_id);
    if (input.partition_number) |v| {
        try body_buf.appendSlice(alloc, "&PartitionNumber=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.tenancy) |v| {
        try body_buf.appendSlice(alloc, "&Tenancy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyInstancePlacementOutput {
    _ = status;
    _ = headers;
    _ = alloc;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyInstancePlacementOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
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
