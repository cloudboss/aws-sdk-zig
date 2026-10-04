const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConformancePackInputParameter = @import("conformance_pack_input_parameter.zig").ConformancePackInputParameter;
const Tag = @import("tag.zig").Tag;
const TemplateSSMDocumentDetails = @import("template_ssm_document_details.zig").TemplateSSMDocumentDetails;

pub const PutConformancePackInput = struct {
    /// A list of `ConformancePackInputParameter` objects.
    conformance_pack_input_parameters: ?[]const ConformancePackInputParameter = null,

    /// The unique name of the conformance pack you want to deploy.
    conformance_pack_name: []const u8,

    /// The name of the Amazon S3 bucket where Config stores conformance pack
    /// templates.
    ///
    /// This field is optional.
    delivery_s3_bucket: ?[]const u8 = null,

    /// The prefix for the Amazon S3 bucket.
    ///
    /// This field is optional.
    delivery_s3_key_prefix: ?[]const u8 = null,

    /// The tags for the conformance pack. Each tag consists of a key and an
    /// optional value, both of which you define.
    tags: ?[]const Tag = null,

    /// A string that contains the full conformance pack template body. The
    /// structure containing the template body has a minimum length of 1 byte and a
    /// maximum length of 51,200 bytes.
    ///
    /// You can use a YAML template with two resource types: Config rule
    /// (`AWS::Config::ConfigRule`) and remediation action
    /// (`AWS::Config::RemediationConfiguration`).
    template_body: ?[]const u8 = null,

    /// The location of the file containing the template body
    /// (`s3://bucketname/prefix`). The uri must point to a conformance pack
    /// template (max size: 300 KB) that is located in an Amazon S3 bucket in the
    /// same Region as the conformance pack.
    ///
    /// You must have access to read Amazon S3 bucket.
    /// In addition, in order to ensure a successful deployment, the template object
    /// must not be in an [archived storage
    /// class](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html) if this parameter is passed.
    template_s3_uri: ?[]const u8 = null,

    /// An object of type `TemplateSSMDocumentDetails`, which contains the name or
    /// the Amazon Resource Name (ARN) of the Amazon Web Services Systems Manager
    /// document (SSM document) and the version of the SSM document that is used to
    /// create a conformance pack.
    template_ssm_document_details: ?TemplateSSMDocumentDetails = null,

    pub const json_field_names = .{
        .conformance_pack_input_parameters = "ConformancePackInputParameters",
        .conformance_pack_name = "ConformancePackName",
        .delivery_s3_bucket = "DeliveryS3Bucket",
        .delivery_s3_key_prefix = "DeliveryS3KeyPrefix",
        .tags = "Tags",
        .template_body = "TemplateBody",
        .template_s3_uri = "TemplateS3Uri",
        .template_ssm_document_details = "TemplateSSMDocumentDetails",
    };
};

pub const PutConformancePackOutput = struct {
    /// ARN of the conformance pack.
    conformance_pack_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .conformance_pack_arn = "ConformancePackArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutConformancePackInput, options: CallOptions) !PutConformancePackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutConformancePackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.PutConformancePack");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutConformancePackOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutConformancePackOutput, body, allocator);
}
