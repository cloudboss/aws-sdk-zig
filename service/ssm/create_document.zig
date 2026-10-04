const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttachmentsSource = @import("attachments_source.zig").AttachmentsSource;
const DocumentFormat = @import("document_format.zig").DocumentFormat;
const DocumentType = @import("document_type.zig").DocumentType;
const DocumentRequires = @import("document_requires.zig").DocumentRequires;
const Tag = @import("tag.zig").Tag;
const DocumentDescription = @import("document_description.zig").DocumentDescription;

pub const CreateDocumentInput = struct {
    /// A list of key-value pairs that describe attachments to a version of a
    /// document.
    attachments: ?[]const AttachmentsSource = null,

    /// The content for the new SSM document in JSON or YAML format. The content of
    /// the document
    /// must not exceed 64KB. This quota also includes the content specified for
    /// input parameters at
    /// runtime. We recommend storing the contents for your new document in an
    /// external JSON or YAML file
    /// and referencing the file in a command.
    ///
    /// For examples, see the following topics in the *Amazon Web Services Systems
    /// Manager User Guide*.
    ///
    /// * [Create an SSM
    /// document
    /// (console)](https://docs.aws.amazon.com/systems-manager/latest/userguide/documents-using.html#create-ssm-console)
    ///
    /// * [Create an
    /// SSM document (command
    /// line)](https://docs.aws.amazon.com/systems-manager/latest/userguide/documents-using.html#create-ssm-document-cli)
    ///
    /// * [Create an
    /// SSM document
    /// (API)](https://docs.aws.amazon.com/systems-manager/latest/userguide/documents-using.html#create-ssm-document-api)
    content: []const u8,

    /// An optional field where you can specify a friendly name for the SSM
    /// document. This value can
    /// differ for each version of the document. You can update this value at a
    /// later time using the
    /// UpdateDocument operation.
    display_name: ?[]const u8 = null,

    /// Specify the document format for the request. The document format can be
    /// JSON, YAML, or TEXT.
    /// JSON is the default format.
    document_format: ?DocumentFormat = null,

    /// The type of document to create.
    ///
    /// The `DeploymentStrategy` document type is an internal-use-only document type
    /// reserved for AppConfig.
    document_type: ?DocumentType = null,

    /// A name for the SSM document.
    ///
    /// You can't use the following strings as document name prefixes. These are
    /// reserved by Amazon Web Services
    /// for use as document name prefixes:
    ///
    /// * `aws`
    ///
    /// * `amazon`
    ///
    /// * `amzn`
    ///
    /// * `AWSEC2`
    ///
    /// * `AWSConfigRemediation`
    ///
    /// * `AWSSupport`
    name: []const u8,

    /// A list of SSM documents required by a document. This parameter is used
    /// exclusively by
    /// AppConfig. When a user creates an AppConfig configuration in an SSM
    /// document, the user must also
    /// specify a required document for validation purposes. In this case, an
    /// `ApplicationConfiguration` document requires an
    /// `ApplicationConfigurationSchema` document for validation purposes. For more
    /// information, see [What is
    /// AppConfig?](https://docs.aws.amazon.com/appconfig/latest/userguide/what-is-appconfig.html) in the
    /// *AppConfig User Guide*.
    requires: ?[]const DocumentRequires = null,

    /// Optional metadata that you assign to a resource. Tags enable you to
    /// categorize a resource in
    /// different ways, such as by purpose, owner, or environment. For example, you
    /// might want to tag an
    /// SSM document to identify the types of targets or the environment where it
    /// will run. In this case,
    /// you could specify the following key-value pairs:
    ///
    /// * `Key=OS,Value=Windows`
    ///
    /// * `Key=Environment,Value=Production`
    ///
    /// To add tags to an existing SSM document, use the AddTagsToResource
    /// operation.
    tags: ?[]const Tag = null,

    /// Specify a target type to define the kinds of resources the document can run
    /// on. For example,
    /// to run a document on EC2 instances, specify the following value:
    /// `/AWS::EC2::Instance`. If you specify a value of '/' the document can run on
    /// all types
    /// of resources. If you don't specify a value, the document can't run on any
    /// resources. For a list
    /// of valid resource types, see [Amazon Web Services resource and
    /// property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the *CloudFormation User Guide*.
    target_type: ?[]const u8 = null,

    /// An optional field specifying the version of the artifact you are creating
    /// with the document.
    /// For example, `Release12.1`. This value is unique across all versions of a
    /// document,
    /// and can't be changed.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments = "Attachments",
        .content = "Content",
        .display_name = "DisplayName",
        .document_format = "DocumentFormat",
        .document_type = "DocumentType",
        .name = "Name",
        .requires = "Requires",
        .tags = "Tags",
        .target_type = "TargetType",
        .version_name = "VersionName",
    };
};

pub const CreateDocumentOutput = struct {
    /// Information about the SSM document.
    document_description: ?DocumentDescription = null,

    pub const json_field_names = .{
        .document_description = "DocumentDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDocumentInput, options: CallOptions) !CreateDocumentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDocumentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.CreateDocument");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDocumentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDocumentOutput, body, allocator);
}
