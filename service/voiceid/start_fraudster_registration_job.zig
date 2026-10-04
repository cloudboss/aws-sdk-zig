const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const RegistrationConfig = @import("registration_config.zig").RegistrationConfig;
const FraudsterRegistrationJob = @import("fraudster_registration_job.zig").FraudsterRegistrationJob;

pub const StartFraudsterRegistrationJobInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The IAM role Amazon Resource Name (ARN) that grants Voice ID permissions to
    /// access
    /// customer's buckets to read the input manifest file and write the Job output
    /// file. Refer
    /// to the [Create and edit a
    /// fraudster
    /// watchlist](https://docs.aws.amazon.com/connect/latest/adminguide/voiceid-fraudster-watchlist.html) documentation for the permissions needed in this
    /// role.
    data_access_role_arn: []const u8,

    /// The identifier of the domain that contains the fraudster registration job
    /// and in which
    /// the fraudsters are registered.
    domain_id: []const u8,

    /// The input data config containing an S3 URI for the input manifest file that
    /// contains
    /// the list of fraudster registration requests.
    input_data_config: InputDataConfig,

    /// The name of the new fraudster registration job.
    job_name: ?[]const u8 = null,

    /// The output data config containing the S3 location where Voice ID writes the
    /// job
    /// output file; you must also include a KMS key ID to encrypt the
    /// file.
    output_data_config: OutputDataConfig,

    /// The registration config containing details such as the action to take when a
    /// duplicate
    /// fraudster is detected, and the similarity threshold to use for detecting a
    /// duplicate
    /// fraudster.
    registration_config: ?RegistrationConfig = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .domain_id = "DomainId",
        .input_data_config = "InputDataConfig",
        .job_name = "JobName",
        .output_data_config = "OutputDataConfig",
        .registration_config = "RegistrationConfig",
    };
};

pub const StartFraudsterRegistrationJobOutput = struct {
    /// Details about the started fraudster registration job.
    job: ?FraudsterRegistrationJob = null,

    pub const json_field_names = .{
        .job = "Job",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartFraudsterRegistrationJobInput, options: CallOptions) !StartFraudsterRegistrationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "voiceid", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartFraudsterRegistrationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voiceid", "Voice ID", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VoiceID.StartFraudsterRegistrationJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartFraudsterRegistrationJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartFraudsterRegistrationJobOutput, body, allocator);
}
