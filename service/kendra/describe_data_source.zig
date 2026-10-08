const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const CustomDocumentEnrichmentConfiguration = @import("custom_document_enrichment_configuration.zig").CustomDocumentEnrichmentConfiguration;
const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;
const DataSourceType = @import("data_source_type.zig").DataSourceType;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

pub const DescribeDataSourceInput = struct {
    /// The identifier of the data source connector.
    id: []const u8,

    /// The identifier of the index used with the data source connector.
    index_id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .index_id = "IndexId",
    };
};

pub const DescribeDataSourceOutput = struct {
    /// Configuration details for the data source connector. This shows how the data
    /// source is
    /// configured. The configuration options for a data source depend on the data
    /// source
    /// provider.
    configuration: ?DataSourceConfiguration = null,

    /// The Unix timestamp when the data source connector was created.
    created_at: ?i64 = null,

    /// Configuration information for altering document metadata and content during
    /// the
    /// document ingestion process when you describe a data source.
    ///
    /// For more information on how to create, modify and delete document metadata,
    /// or make
    /// other content alterations when you ingest documents into Amazon Kendra, see
    /// [Customizing document metadata during the ingestion
    /// process](https://docs.aws.amazon.com/kendra/latest/dg/custom-document-enrichment.html).
    custom_document_enrichment_configuration: ?CustomDocumentEnrichmentConfiguration = null,

    /// The description for the data source connector.
    description: ?[]const u8 = null,

    /// When the `Status` field value is `FAILED`, the
    /// `ErrorMessage` field contains a description of the error that caused the
    /// data
    /// source to fail.
    error_message: ?[]const u8 = null,

    /// The identifier of the data source connector.
    id: ?[]const u8 = null,

    /// The identifier of the index used with the data source connector.
    index_id: ?[]const u8 = null,

    /// The code for a language. This shows a supported language for all
    /// documents in the data source. English is supported by
    /// default. For more information on supported languages, including their codes,
    /// see [Adding
    /// documents in languages other than
    /// English](https://docs.aws.amazon.com/kendra/latest/dg/in-adding-languages.html).
    language_code: ?[]const u8 = null,

    /// The name for the data source connector.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role with permission to
    /// access the data source and required resources.
    role_arn: ?[]const u8 = null,

    /// The schedule for Amazon Kendra to update the index.
    schedule: ?[]const u8 = null,

    /// The current status of the data source connector. When the status is `ACTIVE`
    /// the data source is ready to use. When the status is `FAILED`, the
    /// `ErrorMessage` field contains the reason that the data source failed.
    status: ?DataSourceStatus = null,

    /// The type of the data source. For example, `SHAREPOINT`.
    type: ?DataSourceType = null,

    /// The Unix timestamp when the data source connector was last updated.
    updated_at: ?i64 = null,

    /// Configuration information for an Amazon Virtual Private Cloud to connect to
    /// your data source.
    /// For more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .created_at = "CreatedAt",
        .custom_document_enrichment_configuration = "CustomDocumentEnrichmentConfiguration",
        .description = "Description",
        .error_message = "ErrorMessage",
        .id = "Id",
        .index_id = "IndexId",
        .language_code = "LanguageCode",
        .name = "Name",
        .role_arn = "RoleArn",
        .schedule = "Schedule",
        .status = "Status",
        .type = "Type",
        .updated_at = "UpdatedAt",
        .vpc_configuration = "VpcConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDataSourceInput, options: CallOptions) !DescribeDataSourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDataSourceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DescribeDataSource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDataSourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDataSourceOutput, body, allocator);
}
