const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const JobStatus = @import("job_status.zig").JobStatus;

pub const StartDocumentClassificationJobInput = struct {
    /// A unique identifier for the request. If you do not set the client request
    /// token, Amazon
    /// Comprehend generates one.
    client_request_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data.
    data_access_role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the document classifier to use to process
    /// the
    /// job.
    document_classifier_arn: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the flywheel associated with the model
    /// to use.
    flywheel_arn: ?[]const u8 = null,

    /// Specifies the format and location of the input data for the job.
    input_data_config: InputDataConfig,

    /// The identifier of the job.
    job_name: ?[]const u8 = null,

    /// Specifies where to send the output files.
    output_data_config: OutputDataConfig,

    /// Tags to associate with the document classification job. A tag is a key-value
    /// pair that
    /// adds metadata to a resource used by Amazon Comprehend. For example, a tag
    /// with "Sales" as the
    /// key might be added to a resource to indicate its use by the sales
    /// department.
    tags: ?[]const Tag = null,

    /// ID for the Amazon Web Services Key Management Service (KMS) key that Amazon
    /// Comprehend uses to encrypt
    /// data on the storage volume attached to the ML compute instance(s) that
    /// process the analysis
    /// job. The VolumeKmsKeyId can be either of the following formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    volume_kms_key_id: ?[]const u8 = null,

    /// Configuration parameters for an optional private Virtual Private Cloud (VPC)
    /// containing
    /// the resources you are using for your document classification job. For more
    /// information, see
    /// [Amazon
    /// VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .document_classifier_arn = "DocumentClassifierArn",
        .flywheel_arn = "FlywheelArn",
        .input_data_config = "InputDataConfig",
        .job_name = "JobName",
        .output_data_config = "OutputDataConfig",
        .tags = "Tags",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .vpc_config = "VpcConfig",
    };
};

pub const StartDocumentClassificationJobOutput = struct {
    /// The ARN of the custom classification model.
    document_classifier_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the document classification job. It is a
    /// unique, fully
    /// qualified identifier for the job. It includes the Amazon Web Services
    /// account, Amazon Web Services Region, and the job ID. The
    /// format of the ARN is as follows:
    ///
    /// `arn::comprehend:::document-classification-job/`
    ///
    /// The following is an example job ARN:
    ///
    /// `arn:aws:comprehend:us-west-2:111122223333:document-classification-job/1234abcd12ab34cd56ef1234567890ab`
    job_arn: ?[]const u8 = null,

    /// The identifier generated for the job. To get the status of the job, use this
    /// identifier
    /// with the `DescribeDocumentClassificationJob` operation.
    job_id: ?[]const u8 = null,

    /// The status of the job:
    ///
    /// * SUBMITTED - The job has been received and queued for processing.
    ///
    /// * IN_PROGRESS - Amazon Comprehend is processing the job.
    ///
    /// * COMPLETED - The job was successfully completed and the output is
    ///   available.
    ///
    /// * FAILED - The job did not complete. For details, use the
    /// `DescribeDocumentClassificationJob` operation.
    ///
    /// * STOP_REQUESTED - Amazon Comprehend has received a stop request for the job
    ///   and is
    /// processing the request.
    ///
    /// * STOPPED - The job was successfully stopped without completing.
    job_status: ?JobStatus = null,

    pub const json_field_names = .{
        .document_classifier_arn = "DocumentClassifierArn",
        .job_arn = "JobArn",
        .job_id = "JobId",
        .job_status = "JobStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDocumentClassificationJobInput, options: CallOptions) !StartDocumentClassificationJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDocumentClassificationJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.StartDocumentClassificationJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDocumentClassificationJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartDocumentClassificationJobOutput, body, allocator);
}
