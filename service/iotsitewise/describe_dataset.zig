const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetSource = @import("dataset_source.zig").DatasetSource;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

pub const DescribeDatasetInput = struct {
    /// The ID of the dataset.
    dataset_id: []const u8,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
    };
};

pub const DescribeDatasetOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// of the dataset.
    /// The format is
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:dataset/${DatasetId}`.
    dataset_arn: []const u8,

    /// The dataset creation date, in Unix epoch time.
    dataset_creation_date: i64,

    /// A description about the dataset, and its functionality.
    dataset_description: []const u8,

    /// The ID of the dataset.
    dataset_id: []const u8,

    /// The date the dataset was last updated, in Unix epoch time.
    dataset_last_update_date: i64,

    /// The name of the dataset.
    dataset_name: []const u8,

    /// The data source for the dataset.
    dataset_source: ?DatasetSource = null,

    /// The status of the dataset. This contains the state and any error messages.
    /// State is `CREATING` after a successfull call to this API, and any associated
    /// error message. The state is
    /// `ACTIVE` when ready to use.
    dataset_status: ?DatasetStatus = null,

    /// The version of the dataset.
    dataset_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_arn = "datasetArn",
        .dataset_creation_date = "datasetCreationDate",
        .dataset_description = "datasetDescription",
        .dataset_id = "datasetId",
        .dataset_last_update_date = "datasetLastUpdateDate",
        .dataset_name = "datasetName",
        .dataset_source = "datasetSource",
        .dataset_status = "datasetStatus",
        .dataset_version = "datasetVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDatasetInput, options: CallOptions) !DescribeDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDatasetOutput {
    var result: DescribeDatasetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDatasetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
