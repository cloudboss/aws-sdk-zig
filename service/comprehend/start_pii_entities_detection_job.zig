const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const LanguageCode = @import("language_code.zig").LanguageCode;
const PiiEntitiesDetectionMode = @import("pii_entities_detection_mode.zig").PiiEntitiesDetectionMode;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const RedactionConfig = @import("redaction_config.zig").RedactionConfig;
const Tag = @import("tag.zig").Tag;
const JobStatus = @import("job_status.zig").JobStatus;

pub const StartPiiEntitiesDetectionJobInput = struct {
    /// A unique identifier for the request. If you don't set the client request
    /// token, Amazon
    /// Comprehend generates one.
    client_request_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data.
    data_access_role_arn: []const u8,

    /// The input properties for a PII entities detection job.
    input_data_config: InputDataConfig,

    /// The identifier of the job.
    job_name: ?[]const u8 = null,

    /// The language of the input documents.
    /// Enter the language code for English (en) or Spanish (es).
    language_code: LanguageCode,

    /// Specifies whether the output provides the locations (offsets) of PII
    /// entities or a file in
    /// which PII entities are redacted.
    mode: PiiEntitiesDetectionMode,

    /// Provides conﬁguration parameters for the output of PII entity detection
    /// jobs.
    output_data_config: OutputDataConfig,

    /// Provides configuration parameters for PII entity redaction.
    ///
    /// This parameter is required if you set the `Mode` parameter to
    /// `ONLY_REDACTION`. In that case, you must provide a `RedactionConfig`
    /// definition that includes the `PiiEntityTypes` parameter.
    redaction_config: ?RedactionConfig = null,

    /// Tags to associate with the PII entities detection job. A tag is a key-value
    /// pair that
    /// adds metadata to a resource used by Amazon Comprehend. For example, a tag
    /// with "Sales" as the
    /// key might be added to a resource to indicate its use by the sales
    /// department.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .input_data_config = "InputDataConfig",
        .job_name = "JobName",
        .language_code = "LanguageCode",
        .mode = "Mode",
        .output_data_config = "OutputDataConfig",
        .redaction_config = "RedactionConfig",
        .tags = "Tags",
    };
};

pub const StartPiiEntitiesDetectionJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the PII entity detection job. It is a
    /// unique, fully
    /// qualified identifier for the job. It includes the Amazon Web Services
    /// account, Amazon Web Services Region, and the job ID. The
    /// format of the ARN is as follows:
    ///
    /// `arn::comprehend:::pii-entities-detection-job/`
    ///
    /// The following is an example job ARN:
    ///
    /// `arn:aws:comprehend:us-west-2:111122223333:pii-entities-detection-job/1234abcd12ab34cd56ef1234567890ab`
    job_arn: ?[]const u8 = null,

    /// The identifier generated for the job.
    job_id: ?[]const u8 = null,

    /// The status of the job.
    job_status: ?JobStatus = null,

    pub const json_field_names = .{
        .job_arn = "JobArn",
        .job_id = "JobId",
        .job_status = "JobStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartPiiEntitiesDetectionJobInput, options: CallOptions) !StartPiiEntitiesDetectionJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartPiiEntitiesDetectionJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.StartPiiEntitiesDetectionJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartPiiEntitiesDetectionJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartPiiEntitiesDetectionJobOutput, body, allocator);
}
