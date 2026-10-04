const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReservedNodeExchangeActionType = @import("reserved_node_exchange_action_type.zig").ReservedNodeExchangeActionType;
const ReservedNodeConfigurationOption = @import("reserved_node_configuration_option.zig").ReservedNodeConfigurationOption;
const serde = @import("serde.zig");

pub const GetReservedNodeExchangeConfigurationOptionsInput = struct {
    /// The action type of the reserved-node configuration. The action type can be
    /// an exchange initiated from either a snapshot or a resize.
    action_type: ReservedNodeExchangeActionType,

    /// The identifier for the cluster that is the source for a reserved-node
    /// exchange.
    cluster_identifier: ?[]const u8 = null,

    /// An optional pagination token provided by a previous
    /// `GetReservedNodeExchangeConfigurationOptions` request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value
    /// specified by the `MaxRecords` parameter. You can retrieve the next set of
    /// response
    /// records by providing the returned marker value in the `Marker` parameter and
    /// retrying the request.
    marker: ?[]const u8 = null,

    /// The maximum number of response records to return in each call. If the number
    /// of
    /// remaining response records exceeds the specified `MaxRecords` value, a value
    /// is returned in a `Marker` field of the response. You can retrieve the next
    /// set of records by retrying the command with the returned marker value.
    max_records: ?i32 = null,

    /// The identifier for the snapshot that is the source for the reserved-node
    /// exchange.
    snapshot_identifier: ?[]const u8 = null,
};

pub const GetReservedNodeExchangeConfigurationOptionsOutput = struct {
    /// A pagination token provided by a previous
    /// `GetReservedNodeExchangeConfigurationOptions` request.
    marker: ?[]const u8 = null,

    /// the configuration options for the reserved-node
    /// exchange. These options include information about the source reserved node
    /// and target reserved
    /// node. Details include the node type, the price, the node count, and the
    /// offering
    /// type.
    reserved_node_configuration_option_list: ?[]const ReservedNodeConfigurationOption = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReservedNodeExchangeConfigurationOptionsInput, options: CallOptions) !GetReservedNodeExchangeConfigurationOptionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReservedNodeExchangeConfigurationOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetReservedNodeExchangeConfigurationOptions&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ActionType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.action_type.wireName());
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotIdentifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReservedNodeExchangeConfigurationOptionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetReservedNodeExchangeConfigurationOptionsResult")) break;
            },
            else => {},
        }
    }

    var result: GetReservedNodeExchangeConfigurationOptionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedNodeConfigurationOptionList")) {
                    result.reserved_node_configuration_option_list = try serde.deserializeReservedNodeConfigurationOptionList(allocator, &reader, "ReservedNodeConfigurationOption");
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
