const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetFilter = @import("dataset_filter.zig").DatasetFilter;
const DatasetProperties = @import("dataset_properties.zig").DatasetProperties;

pub const ListDatasetsInput = struct {
    /// Filters the datasets to be returned in the response.
    filter: ?DatasetFilter = null,

    /// The Amazon Resource Number (ARN) of the flywheel.
    flywheel_arn: ?[]const u8 = null,

    /// Maximum number of results to return in a response. The default is 100.
    max_results: ?i32 = null,

    /// Identifies the next page of results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .flywheel_arn = "FlywheelArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListDatasetsOutput = struct {
    /// The dataset properties list.
    dataset_properties_list: ?[]const DatasetProperties = null,

    /// Identifies the next page of results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_properties_list = "DatasetPropertiesList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDatasetsInput, options: CallOptions) !ListDatasetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDatasetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.ListDatasets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDatasetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDatasetsOutput, body, allocator);
}
