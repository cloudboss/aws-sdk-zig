const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartnerIntegrationInfo = @import("partner_integration_info.zig").PartnerIntegrationInfo;
const serde = @import("serde.zig");

pub const DescribePartnersInput = struct {
    /// The Amazon Web Services account ID that owns the cluster.
    account_id: []const u8,

    /// The cluster identifier of the cluster whose partner integration is being
    /// described.
    cluster_identifier: []const u8,

    /// The name of the database whose partner integration is being described. If
    /// database name is not specified, then all databases in the cluster are
    /// described.
    database_name: ?[]const u8 = null,

    /// The name of the partner that is being described. If partner name is not
    /// specified, then all partner integrations are described.
    partner_name: ?[]const u8 = null,
};

pub const DescribePartnersOutput = struct {
    /// A list of partner integrations.
    partner_integration_info_list: ?[]const PartnerIntegrationInfo = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePartnersInput, options: CallOptions) !DescribePartnersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePartnersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribePartners&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&AccountId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.account_id);
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    if (input.database_name) |v| {
        try body_buf.appendSlice(allocator, "&DatabaseName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.partner_name) |v| {
        try body_buf.appendSlice(allocator, "&PartnerName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePartnersOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribePartnersResult")) break;
            },
            else => {},
        }
    }

    var result: DescribePartnersOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PartnerIntegrationInfoList")) {
                    result.partner_integration_info_list = try serde.deserializePartnerIntegrationInfoList(allocator, &reader, "PartnerIntegrationInfo");
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
