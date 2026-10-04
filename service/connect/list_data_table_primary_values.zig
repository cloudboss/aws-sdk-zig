const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrimaryAttributeValueFilter = @import("primary_attribute_value_filter.zig").PrimaryAttributeValueFilter;
const RecordPrimaryValue = @import("record_primary_value.zig").RecordPrimaryValue;

pub const ListDataTablePrimaryValuesInput = struct {
    /// The unique identifier for the data table whose primary values should be
    /// listed.
    data_table_id: []const u8,

    /// The unique identifier for the Amazon Connect instance.
    instance_id: []const u8,

    /// The maximum number of data table primary values to return in one page of
    /// results.
    max_results: ?i32 = null,

    /// Specify the pagination token from a previous request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// Optional filter to retrieve primary values matching specific criteria.
    primary_attribute_values: ?[]const PrimaryAttributeValueFilter = null,

    /// Optional list of specific record IDs to retrieve. Used for CloudFormation to
    /// effectively describe records by ID.
    /// If NextToken is provided, this parameter is ignored.
    record_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .data_table_id = "DataTableId",
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .primary_attribute_values = "PrimaryAttributeValues",
        .record_ids = "RecordIds",
    };
};

pub const ListDataTablePrimaryValuesOutput = struct {
    /// Specify the pagination token from a previous request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// A list of primary value combinations with their record IDs and modification
    /// metadata.
    primary_values_list: ?[]const RecordPrimaryValue = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .primary_values_list = "PrimaryValuesList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataTablePrimaryValuesInput, options: CallOptions) !ListDataTablePrimaryValuesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataTablePrimaryValuesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-tables/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.data_table_id);
    try path_buf.appendSlice(allocator, "/values/list-primary");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.primary_attribute_values) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PrimaryAttributeValues\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.record_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RecordIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataTablePrimaryValuesOutput {
    const result: ListDataTablePrimaryValuesOutput = try aws.json.parseJsonObject(
        ListDataTablePrimaryValuesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
