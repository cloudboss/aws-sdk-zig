const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const SecurityGroup = @import("security_group.zig").SecurityGroup;
const serde = @import("serde.zig");

/// Describes the specified security groups or all of your security groups.
pub const DescribeSecurityGroupsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The filters. If using multiple filters for rules, the results include
    /// security groups for which any combination of rules - not necessarily a
    /// single rule - match all filters.
    ///
    /// * `description` - The description of the security group.
    ///
    /// * `egress.ip-permission.cidr` - An IPv4 CIDR block for an outbound
    /// security group rule.
    ///
    /// * `egress.ip-permission.from-port` - For an outbound rule, the
    /// start of port range for the TCP and UDP protocols, or an ICMP type
    /// number.
    ///
    /// * `egress.ip-permission.group-id` - The ID of a security group
    /// that has been referenced in an outbound security group rule.
    ///
    /// * `egress.ip-permission.group-name` - The name of a security group
    /// that is referenced in an outbound security group rule.
    ///
    /// * `egress.ip-permission.ipv6-cidr` - An IPv6 CIDR block for an
    /// outbound security group rule.
    ///
    /// * `egress.ip-permission.prefix-list-id` - The ID of a prefix list to which a
    ///   security group rule allows outbound access.
    ///
    /// * `egress.ip-permission.protocol` - The IP protocol for an
    /// outbound security group rule (`tcp` | `udp` |
    /// `icmp`, a protocol number, or -1 for all protocols).
    ///
    /// * `egress.ip-permission.to-port` - For an outbound rule, the end
    /// of port range for the TCP and UDP protocols, or an ICMP code.
    ///
    /// * `egress.ip-permission.user-id` - The ID of an Amazon Web Services account
    ///   that
    /// has been referenced in an outbound security group rule.
    ///
    /// * `group-id` - The ID of the security group.
    ///
    /// * `group-name` - The name of the security group.
    ///
    /// * `ip-permission.cidr` - An IPv4 CIDR block for an inbound security
    /// group rule.
    ///
    /// * `ip-permission.from-port` - For an inbound rule, the start of port
    /// range for the TCP and UDP protocols, or an ICMP type number.
    ///
    /// * `ip-permission.group-id` - The ID of a security group that has been
    /// referenced in an inbound security group rule.
    ///
    /// * `ip-permission.group-name` - The name of a security group that is
    /// referenced in an inbound security group rule.
    ///
    /// * `ip-permission.ipv6-cidr` - An IPv6 CIDR block for an inbound security
    /// group rule.
    ///
    /// * `ip-permission.prefix-list-id` - The ID of a prefix list from which a
    ///   security group rule allows inbound access.
    ///
    /// * `ip-permission.protocol` - The IP protocol for an inbound security
    /// group rule (`tcp` | `udp` | `icmp`, a
    /// protocol number, or -1 for all protocols).
    ///
    /// * `ip-permission.to-port` - For an inbound rule, the end of port range
    /// for the TCP and UDP protocols, or an ICMP code.
    ///
    /// * `ip-permission.user-id` - The ID of an Amazon Web Services account that
    ///   has been
    /// referenced in an inbound security group rule.
    ///
    /// * `owner-id` - The Amazon Web Services account ID of the owner of the
    ///   security group.
    ///
    /// * `tag`: - The key/value combination of a tag assigned to the resource. Use
    ///   the tag key in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    ///
    /// * `tag-key` - The key of a tag assigned to the resource. Use this filter to
    ///   find all resources assigned a tag with a specific key, regardless of the
    ///   tag value.
    ///
    /// * `vpc-id` - The ID of the VPC specified when the security group was
    ///   created.
    filters: ?[]const Filter = null,

    /// The IDs of the security groups. Required for security groups in a nondefault
    /// VPC.
    ///
    /// Default: Describes all of your security groups.
    group_ids: ?[]const []const u8 = null,

    /// [Default VPC] The names of the security groups. You can specify either
    /// the security group name or the security group ID.
    ///
    /// Default: Describes all of your security groups.
    group_names: ?[]const []const u8 = null,

    /// The maximum number of items to return for this request. To get the next page
    /// of items,
    /// make another request with the token returned in the output. This value can
    /// be between 5 and 1000.
    /// If this parameter is not specified, then all items are returned. For more
    /// information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request.
    /// Pagination continues from the end of the items returned by the previous
    /// request.
    next_token: ?[]const u8 = null,
};

pub const DescribeSecurityGroupsOutput = struct {
    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there are no more items to return.
    next_token: ?[]const u8 = null,

    /// Information about the security groups.
    security_groups: ?[]const SecurityGroup = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeSecurityGroupsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeSecurityGroupsInput, options: Options) !DescribeSecurityGroupsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeSecurityGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeSecurityGroups&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |fv_1| {
                    try appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&GroupIds.groupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.group_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&GroupNames.GroupName.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeSecurityGroupsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeSecurityGroupsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "securityGroupInfo")) {
                    result.security_groups = try serde.deserializeSecurityGroupList(&reader, alloc, "item");
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
