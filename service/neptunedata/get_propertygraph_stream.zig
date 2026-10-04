const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Encoding = @import("encoding.zig").Encoding;
const IteratorType = @import("iterator_type.zig").IteratorType;
const PropertygraphRecord = @import("propertygraph_record.zig").PropertygraphRecord;

pub const GetPropertygraphStreamInput = struct {
    /// The commit number of the starting record to read from the change-log stream.
    /// This parameter is required when `iteratorType` is`AT_SEQUENCE_NUMBER` or
    /// `AFTER_SEQUENCE_NUMBER`, and ignored when `iteratorType` is `TRIM_HORIZON`
    /// or `LATEST`.
    commit_num: ?i64 = null,

    /// If set to TRUE, Neptune compresses the response using gzip encoding.
    encoding: ?Encoding = null,

    /// Can be one of:
    ///
    /// * `AT_SEQUENCE_NUMBER` - Indicates that reading should start from the event
    ///   sequence number specified jointly by the `commitNum` and `opNum`
    ///   parameters.
    /// * `AFTER_SEQUENCE_NUMBER` - Indicates that reading should start right after
    ///   the event sequence number specified jointly by the `commitNum` and `opNum`
    ///   parameters.
    /// * `TRIM_HORIZON` - Indicates that reading should start at the last untrimmed
    ///   record in the system, which is the oldest unexpired (not yet deleted)
    ///   record in the change-log stream.
    /// * `LATEST` - Indicates that reading should start at the most recent record
    ///   in the system, which is the latest unexpired (not yet deleted) record in
    ///   the change-log stream.
    iterator_type: ?IteratorType = null,

    /// Specifies the maximum number of records to return. There is also a size
    /// limit of 10 MB on the response that can't be modified and that takes
    /// precedence over the number of records specified in the `limit` parameter.
    /// The response does include a threshold-breaching record if the 10 MB limit
    /// was reached.
    ///
    /// The range for `limit` is 1 to 100,000, with a default of 10.
    limit: ?i64 = null,

    /// The operation sequence number within the specified commit to start reading
    /// from in the change-log stream data. The default is `1`.
    op_num: ?i64 = null,

    pub const json_field_names = .{
        .commit_num = "commitNum",
        .encoding = "encoding",
        .iterator_type = "iteratorType",
        .limit = "limit",
        .op_num = "opNum",
    };
};

pub const GetPropertygraphStreamOutput = struct {
    /// Serialization format for the change records being returned. Currently, the
    /// only supported value is `PG_JSON`.
    format: []const u8,

    /// Sequence identifier of the last change in the stream response.
    ///
    /// An event ID is composed of two fields: a `commitNum`, which identifies a
    /// transaction that changed the graph, and an `opNum`, which identifies a
    /// specific operation within that transaction:
    last_event_id: ?[]const aws.map.StringMapEntry = null,

    /// The time at which the commit for the transaction was requested, in
    /// milliseconds from the Unix epoch.
    last_trx_timestamp_in_millis: i64,

    /// An array of serialized change-log stream records included in the response.
    records: ?[]const PropertygraphRecord = null,

    /// The total number of records in the response.
    total_records: i32,

    pub const json_field_names = .{
        .format = "format",
        .last_event_id = "lastEventId",
        .last_trx_timestamp_in_millis = "lastTrxTimestampInMillis",
        .records = "records",
        .total_records = "totalRecords",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPropertygraphStreamInput, options: CallOptions) !GetPropertygraphStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-db", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPropertygraphStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/propertygraph/stream";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.commit_num) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "commitNum=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.iterator_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "iteratorType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.limit) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "limit=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.op_num) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "opNum=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.encoding) |v| {
        try request.headers.put(allocator, "Accept-Encoding", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPropertygraphStreamOutput {
    var result: GetPropertygraphStreamOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPropertygraphStreamOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
