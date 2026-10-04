const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OTelEnrichmentMetricSelector = @import("o_tel_enrichment_metric_selector.zig").OTelEnrichmentMetricSelector;
const OTelEnrichmentStatus = @import("o_tel_enrichment_status.zig").OTelEnrichmentStatus;
const serde = @import("serde.zig");

pub const GetOTelEnrichmentInput = struct {
};

pub const GetOTelEnrichmentOutput = struct {
    /// The date and time that enrichment started for the account. This parameter is
    /// omitted when enrichment is stopped.
    created_at: ?i64 = null,

    /// The metric namespaces, and the metric names, that are left unenriched. This
    /// parameter is omitted when enrichment is stopped, and when enrichment is
    /// running with no
    /// exclude filters, which means that nothing is excluded.
    exclude_filters: ?[]const OTelEnrichmentMetricSelector = null,

    /// The metric namespaces, and the metric names, that are enriched. This
    /// parameter is
    /// omitted when enrichment is stopped, and when enrichment is running with no
    /// include
    /// filters, which means that every supported namespace is in scope.
    include_filters: ?[]const OTelEnrichmentMetricSelector = null,

    /// The status of OTel enrichment for the account. Valid values are
    /// `Running` (enrichment is enabled) and `Stopped` (enrichment is
    /// disabled).
    status: OTelEnrichmentStatus,

    /// The date and time that the enrichment configuration for the account was last
    /// stored.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .exclude_filters = "ExcludeFilters",
        .include_filters = "IncludeFilters",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOTelEnrichmentInput, options: CallOptions) !GetOTelEnrichmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOTelEnrichmentInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetOTelEnrichment&Version=2010-08-01");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOTelEnrichmentOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetOTelEnrichmentResult")) break;
            },
            else => {},
        }
    }

    var result: GetOTelEnrichmentOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ExcludeFilters")) {
                    result.exclude_filters = try serde.deserializeOTelEnrichmentMetricSelectorList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "IncludeFilters")) {
                    result.include_filters = try serde.deserializeOTelEnrichmentMetricSelectorList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = OTelEnrichmentStatus.fromWireName(try reader.readElementText());
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
