const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasourcePackageIngestDetail = @import("datasource_package_ingest_detail.zig").DatasourcePackageIngestDetail;

pub const ListDatasourcePackagesInput = struct {
    /// The ARN of the behavior graph.
    graph_arn: []const u8,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// For requests to get the next page of results, the pagination token that was
    /// returned
    /// with the previous set of results. The initial request does not include a
    /// pagination
    /// token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .graph_arn = "GraphArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListDatasourcePackagesOutput = struct {
    /// Details on the data source packages active in the behavior graph.
    datasource_packages: ?[]const aws.map.MapEntry(DatasourcePackageIngestDetail) = null,

    /// For requests to get the next page of results, the pagination token that was
    /// returned
    /// with the previous set of results. The initial request does not include a
    /// pagination
    /// token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .datasource_packages = "DatasourcePackages",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDatasourcePackagesInput, options: CallOptions) !ListDatasourcePackagesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "detective", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDatasourcePackagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.detective", "Detective", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/graph/datasources/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GraphArn\":");
    try aws.json.writeValue(@TypeOf(input.graph_arn), input.graph_arn, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDatasourcePackagesOutput {
    var result: ListDatasourcePackagesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDatasourcePackagesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
