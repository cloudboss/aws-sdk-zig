const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AddressFamily = @import("address_family.zig").AddressFamily;
const IpamPrefixListResolverRuleRequest = @import("ipam_prefix_list_resolver_rule_request.zig").IpamPrefixListResolverRuleRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const IpamPrefixListResolver = @import("ipam_prefix_list_resolver.zig").IpamPrefixListResolver;
const serde = @import("serde.zig");

pub const CreateIpamPrefixListResolverInput = struct {
    /// The address family for the IPAM prefix list resolver. Valid values are
    /// `ipv4` and `ipv6`. You must create separate resolvers for IPv4 and IPv6
    /// CIDRs as they cannot be mixed in the same resolver.
    address_family: AddressFamily,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description for the IPAM prefix list resolver to help you identify its
    /// purpose and configuration.
    description: ?[]const u8 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the IPAM that will serve as the source of the IP address database
    /// for CIDR selection. The IPAM must be in the Advanced tier to use this
    /// feature.
    ipam_id: []const u8,

    /// The CIDR selection rules for the resolver.
    ///
    /// CIDR selection rules define the business logic for selecting CIDRs from
    /// IPAM. If a CIDR matches any of the rules, it will be included. If a rule has
    /// multiple conditions, the CIDR has to match every condition of that rule. You
    /// can create a prefix list resolver without any CIDR selection rules, but it
    /// will generate empty versions (containing no CIDRs) until you add rules.
    rules: ?[]const IpamPrefixListResolverRuleRequest = null,

    /// The tags to apply to the IPAM prefix list resolver during creation. Tags
    /// help you organize and manage your Amazon Web Services resources.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateIpamPrefixListResolverOutput = struct {
    /// Information about the IPAM prefix list resolver that was created.
    ipam_prefix_list_resolver: ?IpamPrefixListResolver = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIpamPrefixListResolverInput, options: Options) !CreateIpamPrefixListResolverOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateIpamPrefixListResolverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateIpamPrefixListResolver&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&AddressFamily=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.address_family));
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&IpamId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.ipam_id);
    if (input.rules) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.conditions) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.Conditions.Condition.{d}.Cidr=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.cidr) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.Conditions.Condition.{d}.IpamPoolId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.ipam_pool_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.Conditions.Condition.{d}.Operation=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(item_1.operation));
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.Conditions.Condition.{d}.ResourceId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.resource_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.Conditions.Condition.{d}.ResourceOwner=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.resource_owner) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.Conditions.Condition.{d}.ResourceRegion=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.resource_region) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    if (item_1.resource_tag) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.Conditions.Condition.{d}.ResourceTag.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.key) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.Conditions.Condition.{d}.ResourceTag.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.value) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.IpamScopeId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipam_scope_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.RuleType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(item.rule_type));
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Rule.{d}.StaticCidr=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.static_cidr) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateIpamPrefixListResolverOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateIpamPrefixListResolverOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamPrefixListResolver")) {
                    result.ipam_prefix_list_resolver = try serde.deserializeIpamPrefixListResolver(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
