const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdaptersConfig = @import("adapters_config.zig").AdaptersConfig;
const Document = @import("document.zig").Document;
const FeatureType = @import("feature_type.zig").FeatureType;
const HumanLoopConfig = @import("human_loop_config.zig").HumanLoopConfig;
const QueriesConfig = @import("queries_config.zig").QueriesConfig;
const Block = @import("block.zig").Block;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;
const HumanLoopActivationOutput = @import("human_loop_activation_output.zig").HumanLoopActivationOutput;

pub const AnalyzeDocumentInput = struct {
    /// Specifies the adapter to be used when analyzing a document.
    adapters_config: ?AdaptersConfig = null,

    /// The input document as base64-encoded bytes or an Amazon S3 object. If you
    /// use the AWS
    /// CLI to call Amazon Textract operations, you can't pass image bytes. The
    /// document must be an
    /// image in JPEG, PNG, PDF, or TIFF format.
    ///
    /// If you're using an AWS SDK to call Amazon Textract, you might not need to
    /// base64-encode
    /// image bytes that are passed using the `Bytes` field.
    document: Document,

    /// A list of the types of analysis to perform. Add TABLES to the list to return
    /// information
    /// about the tables that are detected in the input document. Add FORMS to
    /// return detected form
    /// data. Add SIGNATURES to return the locations of detected signatures. Add
    /// LAYOUT to the list
    /// to return information about the layout of the document. All lines and words
    /// detected in the document are included in the response (including
    /// text that isn't related to the value of `FeatureTypes`).
    feature_types: []const FeatureType,

    /// Sets the configuration for the human in the loop workflow for analyzing
    /// documents.
    ///
    /// Amazon Textract uses Amazon Augmented AI (A2I) to run the human review
    /// workflows that you specify in `HumanLoopConfig`. A2I entered
    /// maintenance mode in July 2026 and no longer accepts new customers. If your
    /// account is not an
    /// existing A2I customer, requests fail with an
    /// `InvalidParameterException`. For more information, see [AWS
    /// service
    /// availability](https://aws.amazon.com/about-aws/whats-new/2026/06/aws-service-availability/). If you're an existing A2I customer but receive
    /// this error, contact AWS Support and request assistance from the A2I team.
    human_loop_config: ?HumanLoopConfig = null,

    /// Contains Queries and the alias for those Queries, as determined by the
    /// input.
    queries_config: ?QueriesConfig = null,

    pub const json_field_names = .{
        .adapters_config = "AdaptersConfig",
        .document = "Document",
        .feature_types = "FeatureTypes",
        .human_loop_config = "HumanLoopConfig",
        .queries_config = "QueriesConfig",
    };
};

pub const AnalyzeDocumentOutput = struct {
    /// The version of the model used to analyze the document.
    analyze_document_model_version: ?[]const u8 = null,

    /// The items that are detected and analyzed by `AnalyzeDocument`.
    blocks: ?[]const Block = null,

    /// Metadata about the analyzed document. An example is the number of pages.
    document_metadata: ?DocumentMetadata = null,

    /// Shows the results of the human in the loop evaluation.
    human_loop_activation_output: ?HumanLoopActivationOutput = null,

    pub const json_field_names = .{
        .analyze_document_model_version = "AnalyzeDocumentModelVersion",
        .blocks = "Blocks",
        .document_metadata = "DocumentMetadata",
        .human_loop_activation_output = "HumanLoopActivationOutput",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AnalyzeDocumentInput, options: CallOptions) !AnalyzeDocumentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AnalyzeDocumentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Textract.AnalyzeDocument");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AnalyzeDocumentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AnalyzeDocumentOutput, body, allocator);
}
