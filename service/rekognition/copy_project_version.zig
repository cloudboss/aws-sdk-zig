const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OutputConfig = @import("output_config.zig").OutputConfig;

pub const CopyProjectVersionInput = struct {
    /// The ARN of the project in the trusted AWS account that you want to copy the
    /// model version to.
    destination_project_arn: []const u8,

    /// The identifier for your AWS Key Management Service key (AWS KMS key).
    /// You can supply the Amazon Resource Name (ARN) of your KMS key, the ID of
    /// your KMS key,
    /// an alias for your KMS key, or an alias ARN.
    /// The key is used to encrypt training results
    /// and manifest files written to the output Amazon S3 bucket (`OutputConfig`).
    ///
    /// If you choose to use your own KMS key, you need the following permissions on
    /// the KMS key.
    ///
    /// * kms:CreateGrant
    ///
    /// * kms:DescribeKey
    ///
    /// * kms:GenerateDataKey
    ///
    /// * kms:Decrypt
    ///
    /// If you don't specify a value for `KmsKeyId`, images copied into the service
    /// are encrypted
    /// using a key that AWS owns and manages.
    kms_key_id: ?[]const u8 = null,

    /// The S3 bucket and folder location where the training output for the source
    /// model version is placed.
    output_config: OutputConfig,

    /// The ARN of the source project in the trusting AWS account.
    source_project_arn: []const u8,

    /// The ARN of the model version in the source project that you want to copy to
    /// a destination project.
    source_project_version_arn: []const u8,

    /// The key-value tags to assign to the model version.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A name for the version of the model that's copied to the destination
    /// project.
    version_name: []const u8,

    pub const json_field_names = .{
        .destination_project_arn = "DestinationProjectArn",
        .kms_key_id = "KmsKeyId",
        .output_config = "OutputConfig",
        .source_project_arn = "SourceProjectArn",
        .source_project_version_arn = "SourceProjectVersionArn",
        .tags = "Tags",
        .version_name = "VersionName",
    };
};

pub const CopyProjectVersionOutput = struct {
    /// The ARN of the copied model version in the destination project.
    project_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .project_version_arn = "ProjectVersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyProjectVersionInput, options: CallOptions) !CopyProjectVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyProjectVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.CopyProjectVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyProjectVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CopyProjectVersionOutput, body, allocator);
}
