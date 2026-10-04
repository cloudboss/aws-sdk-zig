const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CacheNodeTypeSpecificParameter = @import("cache_node_type_specific_parameter.zig").CacheNodeTypeSpecificParameter;
const Parameter = @import("parameter.zig").Parameter;
const serde = @import("serde.zig");

pub const DescribeCacheParametersInput = struct {
    /// The name of a specific cache parameter group to return details for.
    cache_parameter_group_name: []const u8,

    /// An optional marker returned from a prior request. Use this marker for
    /// pagination of
    /// results from this operation. If this parameter is specified, the response
    /// includes only
    /// records beyond the marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than
    /// the specified `MaxRecords` value, a marker is included in the response so
    /// that the remaining results can be retrieved.
    ///
    /// Default: 100
    ///
    /// Constraints: minimum 20; maximum 100.
    max_records: ?i32 = null,

    /// The parameter types to return.
    ///
    /// Valid values: `user` | `system` |
    /// `engine-default`
    source: ?[]const u8 = null,
};

pub const DescribeCacheParametersOutput = struct {
    /// A list of parameters specific to a particular cache node type. Each element
    /// in the
    /// list contains detailed information about one parameter.
    cache_node_type_specific_parameters: ?[]const CacheNodeTypeSpecificParameter = null,

    /// Provides an identifier to allow retrieval of paginated results.
    marker: ?[]const u8 = null,

    /// A list of Parameter instances.
    parameters: ?[]const Parameter = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCacheParametersInput, options: CallOptions) !DescribeCacheParametersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticache", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCacheParametersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeCacheParameters&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&CacheParameterGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cache_parameter_group_name);
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.source) |v| {
        try body_buf.appendSlice(allocator, "&Source=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCacheParametersOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeCacheParametersResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeCacheParametersOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeTypeSpecificParameters")) {
                    result.cache_node_type_specific_parameters = try serde.deserializeCacheNodeTypeSpecificParametersList(allocator, &reader, "CacheNodeTypeSpecificParameter");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try serde.deserializeParametersList(allocator, &reader, "Parameter");
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
