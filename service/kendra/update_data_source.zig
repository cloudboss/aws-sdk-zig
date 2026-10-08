const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const CustomDocumentEnrichmentConfiguration = @import("custom_document_enrichment_configuration.zig").CustomDocumentEnrichmentConfiguration;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

pub const UpdateDataSourceInput = struct {
    /// Configuration information you want to update for the data source connector.
    configuration: ?DataSourceConfiguration = null,

    /// Configuration information you want to update for altering document metadata
    /// and
    /// content during the document ingestion process.
    ///
    /// For more information on how to create, modify and delete document metadata,
    /// or make
    /// other content alterations when you ingest documents into Amazon Kendra, see
    /// [Customizing document metadata during the ingestion
    /// process](https://docs.aws.amazon.com/kendra/latest/dg/custom-document-enrichment.html).
    custom_document_enrichment_configuration: ?CustomDocumentEnrichmentConfiguration = null,

    /// A new description for the data source connector.
    description: ?[]const u8 = null,

    /// The identifier of the data source connector you want to update.
    id: []const u8,

    /// The identifier of the index used with the data source connector.
    index_id: []const u8,

    /// The code for a language you want to update for the data source connector.
    /// This allows you to support a language for all
    /// documents when updating the data source. English is supported
    /// by default. For more information on supported languages, including their
    /// codes,
    /// see [Adding
    /// documents in languages other than
    /// English](https://docs.aws.amazon.com/kendra/latest/dg/in-adding-languages.html).
    language_code: ?[]const u8 = null,

    /// A new name for the data source connector.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to access
    /// the data source and required resources. For more information, see [IAM roles
    /// for Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
    role_arn: ?[]const u8 = null,

    /// The sync schedule you want to update for the data source connector.
    schedule: ?[]const u8 = null,

    /// Configuration information for an Amazon Virtual Private Cloud to connect to
    /// your data source.
    /// For more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .custom_document_enrichment_configuration = "CustomDocumentEnrichmentConfiguration",
        .description = "Description",
        .id = "Id",
        .index_id = "IndexId",
        .language_code = "LanguageCode",
        .name = "Name",
        .role_arn = "RoleArn",
        .schedule = "Schedule",
        .vpc_configuration = "VpcConfiguration",
    };
};

pub const UpdateDataSourceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataSourceInput, options: CallOptions) !UpdateDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.UpdateDataSource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataSourceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
