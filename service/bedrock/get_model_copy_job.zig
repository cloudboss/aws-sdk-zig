const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelCopyJobStatus = @import("model_copy_job_status.zig").ModelCopyJobStatus;
const Tag = @import("tag.zig").Tag;

pub const GetModelCopyJobInput = struct {
    /// The Amazon Resource Name (ARN) of the model copy job.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
    };
};

pub const GetModelCopyJobOutput = struct {
    /// The time at which the model copy job was created.
    creation_time: i64,

    /// An error message for why the model copy job failed.
    failure_message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the model copy job.
    job_arn: []const u8,

    /// The unique identifier of the account that the model being copied originated
    /// from.
    source_account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the original model being copied.
    source_model_arn: []const u8,

    /// The name of the original model being copied.
    source_model_name: ?[]const u8 = null,

    /// The status of the model copy job.
    status: ModelCopyJobStatus,

    /// The Amazon Resource Name (ARN) of the copied model.
    target_model_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the KMS key encrypting the copied model.
    target_model_kms_key_arn: ?[]const u8 = null,

    /// The name of the copied model.
    target_model_name: ?[]const u8 = null,

    /// The tags associated with the copied model.
    target_model_tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .failure_message = "failureMessage",
        .job_arn = "jobArn",
        .source_account_id = "sourceAccountId",
        .source_model_arn = "sourceModelArn",
        .source_model_name = "sourceModelName",
        .status = "status",
        .target_model_arn = "targetModelArn",
        .target_model_kms_key_arn = "targetModelKmsKeyArn",
        .target_model_name = "targetModelName",
        .target_model_tags = "targetModelTags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetModelCopyJobInput, options: CallOptions) !GetModelCopyJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetModelCopyJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/model-copy-jobs/");
    try path_buf.appendSlice(allocator, input.job_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetModelCopyJobOutput {
    const result: GetModelCopyJobOutput = try aws.json.parseJsonObject(
        GetModelCopyJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
