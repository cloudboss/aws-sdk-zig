const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IngestionInputConfiguration = @import("ingestion_input_configuration.zig").IngestionInputConfiguration;
const IngestionJobStatus = @import("ingestion_job_status.zig").IngestionJobStatus;

pub const StartDataIngestionJobInput = struct {
    /// A unique identifier for the request. If you do not set the client request
    /// token, Amazon
    /// Lookout for Equipment generates one.
    client_token: []const u8,

    /// The name of the dataset being used by the data ingestion job.
    dataset_name: []const u8,

    /// Specifies information for the input data for the data ingestion job,
    /// including dataset
    /// S3 location.
    ingestion_input_configuration: IngestionInputConfiguration,

    /// The Amazon Resource Name (ARN) of a role with permission to access the data
    /// source for
    /// the data ingestion job.
    role_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .dataset_name = "DatasetName",
        .ingestion_input_configuration = "IngestionInputConfiguration",
        .role_arn = "RoleArn",
    };
};

pub const StartDataIngestionJobOutput = struct {
    /// Indicates the job ID of the data ingestion job.
    job_id: ?[]const u8 = null,

    /// Indicates the status of the `StartDataIngestionJob` operation.
    status: ?IngestionJobStatus = null,

    pub const json_field_names = .{
        .job_id = "JobId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDataIngestionJobInput, options: CallOptions) !StartDataIngestionJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDataIngestionJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.StartDataIngestionJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDataIngestionJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartDataIngestionJobOutput, body, allocator);
}
