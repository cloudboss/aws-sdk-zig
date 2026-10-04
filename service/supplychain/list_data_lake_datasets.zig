const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataLakeDataset = @import("data_lake_dataset.zig").DataLakeDataset;

pub const ListDataLakeDatasetsInput = struct {
    /// The Amazon Web Services Supply Chain instance identifier.
    instance_id: []const u8,

    /// The max number of datasets to fetch in this paginated request.
    max_results: ?i32 = null,

    /// The namespace of the dataset, besides the custom defined namespace, every
    /// instance comes with below pre-defined namespaces:
    ///
    /// * **asc** - For information on the Amazon Web Services Supply Chain
    ///   supported datasets see
    ///   [https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html).
    ///
    /// * **default** - For datasets with custom user-defined schemas.
    namespace: []const u8,

    /// The pagination token to fetch next page of datasets.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_id = "instanceId",
        .max_results = "maxResults",
        .namespace = "namespace",
        .next_token = "nextToken",
    };
};

pub const ListDataLakeDatasetsOutput = struct {
    /// The list of fetched dataset details.
    datasets: ?[]const DataLakeDataset = null,

    /// The pagination token to fetch next page of datasets.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .datasets = "datasets",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataLakeDatasetsInput, options: CallOptions) !ListDataLakeDatasetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataLakeDatasetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/datalake/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/namespaces/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/datasets");
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

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataLakeDatasetsOutput {
    var result: ListDataLakeDatasetsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDataLakeDatasetsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
