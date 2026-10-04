const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EdiType = @import("edi_type.zig").EdiType;
const FileFormat = @import("file_format.zig").FileFormat;
const InputConversion = @import("input_conversion.zig").InputConversion;
const Mapping = @import("mapping.zig").Mapping;
const OutputConversion = @import("output_conversion.zig").OutputConversion;
const SampleDocuments = @import("sample_documents.zig").SampleDocuments;
const TransformerStatus = @import("transformer_status.zig").TransformerStatus;

pub const UpdateTransformerInput = struct {
    /// Specifies the details for the EDI standard that is being used for the
    /// transformer. Currently, only X12 is supported. X12 is a set of standards and
    /// corresponding messages that define specific business documents.
    edi_type: ?EdiType = null,

    /// Specifies that the currently supported file formats for EDI transformations
    /// are `JSON` and `XML`.
    file_format: ?FileFormat = null,

    /// To update, specify the `InputConversion` object, which contains the format
    /// options for the inbound transformation.
    input_conversion: ?InputConversion = null,

    /// Specify the structure that contains the mapping template and its language
    /// (either XSLT or JSONATA).
    mapping: ?Mapping = null,

    /// Specifies the mapping template for the transformer. This template is used to
    /// map the parsed EDI file using JSONata or XSLT.
    ///
    /// This parameter is available for backwards compatibility. Use the
    /// [Mapping](https://docs.aws.amazon.com/b2bi/latest/APIReference/API_Mapping.html) data type instead.
    mapping_template: ?[]const u8 = null,

    /// Specify a new name for the transformer, if you want to update it.
    name: ?[]const u8 = null,

    /// To update, specify the `OutputConversion` object, which contains the format
    /// options for the outbound transformation.
    output_conversion: ?OutputConversion = null,

    /// Specifies a sample EDI document that is used by a transformer as a guide for
    /// processing the EDI data.
    sample_document: ?[]const u8 = null,

    /// Specify a structure that contains the Amazon S3 bucket and an array of the
    /// corresponding keys used to identify the location for your sample documents.
    sample_documents: ?SampleDocuments = null,

    /// Specifies the transformer's status. You can update the state of the
    /// transformer from `inactive` to `active`.
    status: ?TransformerStatus = null,

    /// Specifies the system-assigned unique identifier for the transformer.
    transformer_id: []const u8,

    pub const json_field_names = .{
        .edi_type = "ediType",
        .file_format = "fileFormat",
        .input_conversion = "inputConversion",
        .mapping = "mapping",
        .mapping_template = "mappingTemplate",
        .name = "name",
        .output_conversion = "outputConversion",
        .sample_document = "sampleDocument",
        .sample_documents = "sampleDocuments",
        .status = "status",
        .transformer_id = "transformerId",
    };
};

pub const UpdateTransformerOutput = struct {
    /// Returns a timestamp for creation date and time of the transformer.
    created_at: i64,

    /// Returns the details for the EDI standard that is being used for the
    /// transformer. Currently, only X12 is supported. X12 is a set of standards and
    /// corresponding messages that define specific business documents.
    edi_type: ?EdiType = null,

    /// Returns that the currently supported file formats for EDI transformations
    /// are `JSON` and `XML`.
    file_format: ?FileFormat = null,

    /// Returns the `InputConversion` object, which contains the format options for
    /// the inbound transformation.
    input_conversion: ?InputConversion = null,

    /// Returns the structure that contains the mapping template and its language
    /// (either XSLT or JSONATA).
    mapping: ?Mapping = null,

    /// Returns the mapping template for the transformer. This template is used to
    /// map the parsed EDI file using JSONata or XSLT.
    mapping_template: ?[]const u8 = null,

    /// Returns a timestamp for last time the transformer was modified.
    modified_at: i64,

    /// Returns the name of the transformer.
    name: []const u8,

    /// Returns the `OutputConversion` object, which contains the format options for
    /// the outbound transformation.
    output_conversion: ?OutputConversion = null,

    /// Returns a sample EDI document that is used by a transformer as a guide for
    /// processing the EDI data.
    sample_document: ?[]const u8 = null,

    /// Returns a structure that contains the Amazon S3 bucket and an array of the
    /// corresponding keys used to identify the location for your sample documents.
    sample_documents: ?SampleDocuments = null,

    /// Returns the state of the newly created transformer. The transformer can be
    /// either `active` or `inactive`. For the transformer to be used in a
    /// capability, its status must `active`.
    status: TransformerStatus,

    /// Returns an Amazon Resource Name (ARN) for a specific Amazon Web Services
    /// resource, such as a capability, partnership, profile, or transformer.
    transformer_arn: []const u8,

    /// Returns the system-assigned unique identifier for the transformer.
    transformer_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .edi_type = "ediType",
        .file_format = "fileFormat",
        .input_conversion = "inputConversion",
        .mapping = "mapping",
        .mapping_template = "mappingTemplate",
        .modified_at = "modifiedAt",
        .name = "name",
        .output_conversion = "outputConversion",
        .sample_document = "sampleDocument",
        .sample_documents = "sampleDocuments",
        .status = "status",
        .transformer_arn = "transformerArn",
        .transformer_id = "transformerId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTransformerInput, options: CallOptions) !UpdateTransformerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "b2bi", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTransformerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("b2bi", "b2bi", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.UpdateTransformer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTransformerOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateTransformerOutput, body, allocator);
}
