const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ResourcePendingMaintenanceActions = @import("resource_pending_maintenance_actions.zig").ResourcePendingMaintenanceActions;
const serde = @import("serde.zig");

pub const DescribePendingMaintenanceActionsInput = struct {
    /// A filter that specifies one or more resources to return pending maintenance
    /// actions for.
    ///
    /// Supported filters:
    ///
    /// * `db-cluster-id` - Accepts DB cluster identifiers and DB cluster Amazon
    ///   Resource Names (ARNs). The results list only includes pending maintenance
    ///   actions for the DB clusters identified by these ARNs.
    /// * `db-instance-id` - Accepts DB instance identifiers and DB instance ARNs.
    ///   The results list only includes pending maintenance actions for the DB
    ///   instances identified by these ARNs.
    filters: ?[]const Filter = null,

    /// An optional pagination token provided by a previous
    /// `DescribePendingMaintenanceActions` request. If this parameter is specified,
    /// the response includes only records beyond the marker, up to a number of
    /// records specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified `MaxRecords` value, a pagination token called a
    /// marker is included in the response so that you can retrieve the remaining
    /// results.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// The ARN of a resource to return pending maintenance actions for.
    resource_identifier: ?[]const u8 = null,
};

pub const DescribePendingMaintenanceActionsOutput = struct {
    /// An optional pagination token provided by a previous
    /// `DescribePendingMaintenanceActions` request. If this parameter is specified,
    /// the response includes only records beyond the marker, up to a number of
    /// records specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// A list of the pending maintenance actions for the resource.
    pending_maintenance_actions: ?[]const ResourcePendingMaintenanceActions = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePendingMaintenanceActionsInput, options: CallOptions) !DescribePendingMaintenanceActionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePendingMaintenanceActionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribePendingMaintenanceActions&Version=2014-10-31");
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
            }
            for (item.values, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.Value.{d}=", .{ n, n_1 }) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
            }
        }
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.resource_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ResourceIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePendingMaintenanceActionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribePendingMaintenanceActionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribePendingMaintenanceActionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingMaintenanceActions")) {
                    result.pending_maintenance_actions = try serde.deserializePendingMaintenanceActions(allocator, &reader, "ResourcePendingMaintenanceActions");
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
