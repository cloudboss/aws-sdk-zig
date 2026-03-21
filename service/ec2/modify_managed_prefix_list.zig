const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AddPrefixListEntry = @import("add_prefix_list_entry.zig").AddPrefixListEntry;
const RemovePrefixListEntry = @import("remove_prefix_list_entry.zig").RemovePrefixListEntry;
const ManagedPrefixList = @import("managed_prefix_list.zig").ManagedPrefixList;
const serde = @import("serde.zig");

pub const ModifyManagedPrefixListInput = struct {
    /// One or more entries to add to the prefix list.
    add_entries: ?[]const AddPrefixListEntry = null,

    /// The current version of the prefix list.
    current_version: ?i64 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Indicates whether synchronization with an IPAM prefix list resolver should
    /// be enabled for this managed prefix list. When enabled, the prefix list CIDRs
    /// are automatically updated based on the associated resolver's CIDR selection
    /// rules.
    ipam_prefix_list_resolver_sync_enabled: ?bool = null,

    /// The maximum number of entries for the prefix list. You cannot modify the
    /// entries
    /// of a prefix list and modify the size of a prefix list at the same time.
    ///
    /// If any of the resources that reference the prefix list cannot support the
    /// new
    /// maximum size, the modify operation fails. Check the state message for the
    /// IDs of
    /// the first ten resources that do not support the new maximum size.
    max_entries: ?i32 = null,

    /// The ID of the prefix list.
    prefix_list_id: []const u8,

    /// A name for the prefix list.
    prefix_list_name: ?[]const u8 = null,

    /// One or more entries to remove from the prefix list.
    remove_entries: ?[]const RemovePrefixListEntry = null,
};

pub const ModifyManagedPrefixListOutput = struct {
    /// Information about the prefix list.
    prefix_list: ?ManagedPrefixList = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyManagedPrefixListInput, options: CallOptions) !ModifyManagedPrefixListOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyManagedPrefixListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyManagedPrefixList&Version=2016-11-15");
    if (input.add_entries) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddEntry.{d}.Cidr=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.cidr);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.description) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddEntry.{d}.Description=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.current_version) |v| {
        try body_buf.appendSlice(allocator, "&CurrentVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.ipam_prefix_list_resolver_sync_enabled) |v| {
        try body_buf.appendSlice(allocator, "&IpamPrefixListResolverSyncEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.max_entries) |v| {
        try body_buf.appendSlice(allocator, "&MaxEntries=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&PrefixListId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.prefix_list_id);
    if (input.prefix_list_name) |v| {
        try body_buf.appendSlice(allocator, "&PrefixListName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.remove_entries) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveEntry.{d}.Cidr=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.cidr);
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyManagedPrefixListOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyManagedPrefixListOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "prefixList")) {
                    result.prefix_list = try serde.deserializeManagedPrefixList(allocator, &reader);
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
