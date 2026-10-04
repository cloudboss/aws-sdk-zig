const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdaptersConfig = @import("adapters_config.zig").AdaptersConfig;
const DocumentLocation = @import("document_location.zig").DocumentLocation;
const FeatureType = @import("feature_type.zig").FeatureType;
const NotificationChannel = @import("notification_channel.zig").NotificationChannel;
const OutputConfig = @import("output_config.zig").OutputConfig;
const QueriesConfig = @import("queries_config.zig").QueriesConfig;

pub const StartDocumentAnalysisInput = struct {
    /// Specifies the adapter to be used when analyzing a document.
    adapters_config: ?AdaptersConfig = null,

    /// The idempotent token that you use to identify the start request. If you use
    /// the same
    /// token with multiple `StartDocumentAnalysis` requests, the same
    /// `JobId` is returned. Use `ClientRequestToken` to prevent the same
    /// job from being accidentally started more than once. For more information,
    /// see
    /// [Calling Amazon Textract Asynchronous
    /// Operations](https://docs.aws.amazon.com/textract/latest/dg/api-async.html).
    client_request_token: ?[]const u8 = null,

    /// The location of the document to be processed.
    document_location: DocumentLocation,

    /// A list of the types of analysis to perform. Add TABLES to the list to return
    /// information
    /// about the tables that are detected in the input document. Add FORMS to
    /// return detected
    /// form data. To perform both types of analysis, add TABLES
    /// and FORMS to `FeatureTypes`. All lines and words detected in the document
    /// are
    /// included in the response (including text that isn't related to the value of
    /// `FeatureTypes`).
    feature_types: []const FeatureType,

    /// An identifier that you specify that's included in the completion
    /// notification published
    /// to the Amazon SNS topic. For example, you can use `JobTag` to identify the
    /// type of
    /// document that the completion notification corresponds to (such as a tax form
    /// or a
    /// receipt).
    job_tag: ?[]const u8 = null,

    /// The KMS key used to encrypt the inference results. This can be
    /// in either Key ID or Key Alias format. When a KMS key is provided, the
    /// KMS key will be used for server-side encryption of the objects in the
    /// customer bucket. When this parameter is not enabled, the result will
    /// be encrypted server side,using SSE-S3.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon SNS topic ARN that you want Amazon Textract to publish the
    /// completion status of the
    /// operation to.
    notification_channel: ?NotificationChannel = null,

    /// Sets if the output will go to a customer defined bucket. By default, Amazon
    /// Textract will save
    /// the results internally to be accessed by the GetDocumentAnalysis operation.
    output_config: ?OutputConfig = null,

    queries_config: ?QueriesConfig = null,

    pub const json_field_names = .{
        .adapters_config = "AdaptersConfig",
        .client_request_token = "ClientRequestToken",
        .document_location = "DocumentLocation",
        .feature_types = "FeatureTypes",
        .job_tag = "JobTag",
        .kms_key_id = "KMSKeyId",
        .notification_channel = "NotificationChannel",
        .output_config = "OutputConfig",
        .queries_config = "QueriesConfig",
    };
};

pub const StartDocumentAnalysisOutput = struct {
    /// The identifier for the document text detection job. Use `JobId` to identify
    /// the job in a subsequent call to `GetDocumentAnalysis`. A `JobId` value
    /// is only valid for 7 days.
    job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDocumentAnalysisInput, options: CallOptions) !StartDocumentAnalysisOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "textract", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDocumentAnalysisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("textract", "Textract", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Textract.StartDocumentAnalysis");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDocumentAnalysisOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartDocumentAnalysisOutput, body, allocator);
}
