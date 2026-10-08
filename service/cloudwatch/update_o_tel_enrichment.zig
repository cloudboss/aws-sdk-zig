const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OTelEnrichmentMetricSelector = @import("o_tel_enrichment_metric_selector.zig").OTelEnrichmentMetricSelector;
const serde = @import("serde.zig");

pub const UpdateOTelEnrichmentInput = struct {
    /// The metric namespaces, and the metric names, to leave unenriched. If this
    /// parameter
    /// is omitted, nothing is excluded.
    ///
    /// Amazon CloudWatch applies `ExcludeFilters` after
    /// `IncludeFilters`, so a metric that both parameters match is not
    /// enriched.
    ///
    /// A maximum of 100 filters is allowed across `IncludeFilters` and
    /// `ExcludeFilters` combined.
    exclude_filters: ?[]const OTelEnrichmentMetricSelector = null,

    /// The metric namespaces, and the metric names, to enrich. If this parameter is
    /// omitted, every namespace that Amazon CloudWatch supports for enrichment is
    /// in
    /// scope.
    ///
    /// A maximum of 100 filters is allowed across `IncludeFilters` and
    /// `ExcludeFilters` combined.
    include_filters: ?[]const OTelEnrichmentMetricSelector = null,

    pub const json_field_names = .{
        .exclude_filters = "ExcludeFilters",
        .include_filters = "IncludeFilters",
    };
};

pub const UpdateOTelEnrichmentOutput = struct {
    /// The date and time that enrichment started for the account.
    created_at: ?i64 = null,

    /// The exclude filters that are stored for the account after the replacement.
    /// This
    /// parameter is omitted when the request cleared the exclude filters, which
    /// means that
    /// nothing is excluded.
    exclude_filters: ?[]const OTelEnrichmentMetricSelector = null,

    /// The include filters that are stored for the account after the replacement.
    /// This
    /// parameter is omitted when the request cleared the include filters, which
    /// means that
    /// every supported namespace is in scope.
    include_filters: ?[]const OTelEnrichmentMetricSelector = null,

    /// The date and time that the enrichment configuration for the account was last
    /// stored.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .exclude_filters = "ExcludeFilters",
        .include_filters = "IncludeFilters",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOTelEnrichmentInput, options: CallOptions) !UpdateOTelEnrichmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOTelEnrichmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateOTelEnrichment&Version=2010-08-01");
    if (input.exclude_filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.metric_names) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludeFilters.member.{d}.MetricNames.member.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludeFilters.member.{d}.Namespace=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.namespace);
            }
        }
    }
    if (input.include_filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.metric_names) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IncludeFilters.member.{d}.MetricNames.member.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IncludeFilters.member.{d}.Namespace=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.namespace);
            }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOTelEnrichmentOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UpdateOTelEnrichmentResult")) break;
            },
            else => {},
        }
    }

    var result: UpdateOTelEnrichmentOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ExcludeFilters")) {
                    result.exclude_filters = try serde.deserializeOTelEnrichmentMetricSelectorList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "IncludeFilters")) {
                    result.include_filters = try serde.deserializeOTelEnrichmentMetricSelectorList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "UpdatedAt")) {
                    result.updated_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
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
