const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetLabelDescription = @import("dataset_label_description.zig").DatasetLabelDescription;

pub const ListDatasetLabelsInput = struct {
    /// The Amazon Resource Name (ARN) of the dataset that you want to use.
    dataset_arn: []const u8,

    /// The maximum number of results to return per paginated call. The largest
    /// value you can specify is 100.
    /// If you specify a value greater than 100, a ValidationException
    /// error occurs. The default value is 100.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there is more
    /// results to retrieve), Amazon Rekognition Custom Labels returns a pagination
    /// token in the response. You can use this pagination
    /// token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListDatasetLabelsOutput = struct {
    /// A list of the labels in the dataset.
    dataset_label_descriptions: ?[]const DatasetLabelDescription = null,

    /// If the previous response was incomplete (because there is more
    /// results to retrieve), Amazon Rekognition Custom Labels returns a pagination
    /// token in the response. You can use this pagination
    /// token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_label_descriptions = "DatasetLabelDescriptions",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDatasetLabelsInput, options: CallOptions) !ListDatasetLabelsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDatasetLabelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.ListDatasetLabels");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDatasetLabelsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDatasetLabelsOutput, body, allocator);
}
