const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListDatasetEntriesInput = struct {
    /// Specifies a label filter for the response. The response includes an entry
    /// only if one or more of the labels in `ContainsLabels` exist in the entry.
    contains_labels: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) for the dataset that you want to use.
    dataset_arn: []const u8,

    /// Specifies an error filter for the response. Specify `True` to only include
    /// entries that have errors.
    has_errors: ?bool = null,

    /// Specify `true` to get only the JSON Lines where the image is labeled.
    /// Specify `false` to get only the JSON Lines where the image isn't labeled. If
    /// you
    /// don't specify `Labeled`, `ListDatasetEntries` returns JSON Lines for labeled
    /// and unlabeled
    /// images.
    labeled: ?bool = null,

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

    /// If specified, `ListDatasetEntries` only returns JSON Lines where the value
    /// of `SourceRefContains` is
    /// part of the `source-ref` field. The `source-ref` field contains the Amazon
    /// S3 location of the image.
    /// You can use `SouceRefContains` for tasks such as getting the JSON Line for a
    /// single image, or gettting JSON Lines for all images within a specific
    /// folder.
    source_ref_contains: ?[]const u8 = null,

    pub const json_field_names = .{
        .contains_labels = "ContainsLabels",
        .dataset_arn = "DatasetArn",
        .has_errors = "HasErrors",
        .labeled = "Labeled",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .source_ref_contains = "SourceRefContains",
    };
};

pub const ListDatasetEntriesOutput = struct {
    /// A list of entries (images) in the dataset.
    dataset_entries: ?[]const []const u8 = null,

    /// If the previous response was incomplete (because there is more
    /// results to retrieve), Amazon Rekognition Custom Labels returns a pagination
    /// token in the response. You can use this pagination
    /// token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_entries = "DatasetEntries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDatasetEntriesInput, options: CallOptions) !ListDatasetEntriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDatasetEntriesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.ListDatasetEntries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDatasetEntriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDatasetEntriesOutput, body, allocator);
}
