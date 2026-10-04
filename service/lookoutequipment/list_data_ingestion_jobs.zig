const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IngestionJobStatus = @import("ingestion_job_status.zig").IngestionJobStatus;
const DataIngestionJobSummary = @import("data_ingestion_job_summary.zig").DataIngestionJobSummary;

pub const ListDataIngestionJobsInput = struct {
    /// The name of the dataset being used for the data ingestion job.
    dataset_name: ?[]const u8 = null,

    /// Specifies the maximum number of data ingestion jobs to list.
    max_results: ?i32 = null,

    /// An opaque pagination token indicating where to continue the listing of data
    /// ingestion
    /// jobs.
    next_token: ?[]const u8 = null,

    /// Indicates the status of the data ingestion job.
    status: ?IngestionJobStatus = null,

    pub const json_field_names = .{
        .dataset_name = "DatasetName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListDataIngestionJobsOutput = struct {
    /// Specifies information about the specific data ingestion job, including
    /// dataset name and
    /// status.
    data_ingestion_job_summaries: ?[]const DataIngestionJobSummary = null,

    /// An opaque pagination token indicating where to continue the listing of data
    /// ingestion
    /// jobs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_ingestion_job_summaries = "DataIngestionJobSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataIngestionJobsInput, options: CallOptions) !ListDataIngestionJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataIngestionJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ListDataIngestionJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataIngestionJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDataIngestionJobsOutput, body, allocator);
}
