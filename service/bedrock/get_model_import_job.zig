const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelDataSource = @import("model_data_source.zig").ModelDataSource;
const ModelImportJobStatus = @import("model_import_job_status.zig").ModelImportJobStatus;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const GetModelImportJobInput = struct {
    /// The identifier of the import job.
    job_identifier: []const u8,

    pub const json_field_names = .{
        .job_identifier = "jobIdentifier",
    };
};

pub const GetModelImportJobOutput = struct {
    /// The time the resource was created.
    creation_time: ?i64 = null,

    /// Time that the resource transitioned to terminal state.
    end_time: ?i64 = null,

    /// Information about why the import job failed.
    failure_message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the imported model.
    imported_model_arn: ?[]const u8 = null,

    /// The imported model is encrypted at rest using this key.
    imported_model_kms_key_arn: ?[]const u8 = null,

    /// The name of the imported model.
    imported_model_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the import job.
    job_arn: ?[]const u8 = null,

    /// The name of the import job.
    job_name: ?[]const u8 = null,

    /// Time the resource was last modified.
    last_modified_time: ?i64 = null,

    /// The data source for the imported model.
    model_data_source: ?ModelDataSource = null,

    /// The Amazon Resource Name (ARN) of the IAM role associated with this job.
    role_arn: ?[]const u8 = null,

    /// The status of the job. A successful job transitions from in-progress to
    /// completed when the imported model is ready to use. If the job failed, the
    /// failure message contains information about why the job failed.
    status: ?ModelImportJobStatus = null,

    /// The Virtual Private Cloud (VPC) configuration of the import model job.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .end_time = "endTime",
        .failure_message = "failureMessage",
        .imported_model_arn = "importedModelArn",
        .imported_model_kms_key_arn = "importedModelKmsKeyArn",
        .imported_model_name = "importedModelName",
        .job_arn = "jobArn",
        .job_name = "jobName",
        .last_modified_time = "lastModifiedTime",
        .model_data_source = "modelDataSource",
        .role_arn = "roleArn",
        .status = "status",
        .vpc_config = "vpcConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetModelImportJobInput, options: CallOptions) !GetModelImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetModelImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/model-import-jobs/");
    try path_buf.appendSlice(allocator, input.job_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetModelImportJobOutput {
    var result: GetModelImportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetModelImportJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
