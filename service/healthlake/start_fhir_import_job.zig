const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const ValidationLevel = @import("validation_level.zig").ValidationLevel;
const JobStatus = @import("job_status.zig").JobStatus;

pub const StartFHIRImportJobInput = struct {
    /// The optional user-provided token used for ensuring API idempotency.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that grants access permission to AWS
    /// HealthLake.
    data_access_role_arn: []const u8,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The input properties for the import job request.
    input_data_config: InputDataConfig,

    /// The import job name.
    job_name: ?[]const u8 = null,

    job_output_data_config: OutputDataConfig,

    /// The validation level of the import job.
    validation_level: ?ValidationLevel = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .datastore_id = "DatastoreId",
        .input_data_config = "InputDataConfig",
        .job_name = "JobName",
        .job_output_data_config = "JobOutputDataConfig",
        .validation_level = "ValidationLevel",
    };
};

pub const StartFHIRImportJobOutput = struct {
    /// The data store identifier.
    datastore_id: ?[]const u8 = null,

    /// The import job identifier.
    job_id: []const u8,

    /// The import job status.
    job_status: JobStatus,

    pub const json_field_names = .{
        .datastore_id = "DatastoreId",
        .job_id = "JobId",
        .job_status = "JobStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartFHIRImportJobInput, options: CallOptions) !StartFHIRImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "healthlake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartFHIRImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("healthlake", "HealthLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.StartFHIRImportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartFHIRImportJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartFHIRImportJobOutput, body, allocator);
}
