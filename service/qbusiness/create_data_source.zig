const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentEnrichmentConfiguration = @import("document_enrichment_configuration.zig").DocumentEnrichmentConfiguration;
const MediaExtractionConfiguration = @import("media_extraction_configuration.zig").MediaExtractionConfiguration;
const Tag = @import("tag.zig").Tag;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

pub const CreateDataSourceInput = struct {
    /// The identifier of the Amazon Q Business application the data source will be
    /// attached to.
    application_id: []const u8,

    /// A token you provide to identify a request to create a data source connector.
    /// Multiple calls to the `CreateDataSource` API with the same client token will
    /// create only one data source connector.
    client_token: ?[]const u8 = null,

    /// Configuration information to connect your data source repository to Amazon Q
    /// Business. Use this parameter to provide a JSON schema with configuration
    /// information specific to your data source connector.
    ///
    /// Each data source has a JSON schema provided by Amazon Q Business that you
    /// must use. For example, the Amazon S3 and Web Crawler connectors require the
    /// following JSON schemas:
    ///
    /// * [Amazon S3 JSON
    ///   schema](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/s3-api.html)
    /// * [Web Crawler JSON
    ///   schema](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/web-crawler-api.html)
    ///
    /// You can find configuration templates for your specific data source using the
    /// following steps:
    ///
    /// * Navigate to the [Supported
    ///   connectors](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/connectors-list.html) page in the Amazon Q Business User Guide, and select the data source of your choice.
    /// * Then, from your specific data source connector page, select **Using the
    ///   API**. You will find the JSON schema for your data source, including
    ///   parameter descriptions, in this section.
    configuration: []const u8,

    /// A description for the data source connector.
    description: ?[]const u8 = null,

    /// A name for the data source connector.
    display_name: []const u8,

    document_enrichment_configuration: ?DocumentEnrichmentConfiguration = null,

    /// The identifier of the index that you want to use with the data source
    /// connector.
    index_id: []const u8,

    /// The configuration for extracting information from media in documents during
    /// ingestion.
    media_extraction_configuration: ?MediaExtractionConfiguration = null,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to access the
    /// data source and required resources. This field is required for all connector
    /// types except custom connectors, where it is optional.
    role_arn: ?[]const u8 = null,

    /// Sets the frequency for Amazon Q Business to check the documents in your data
    /// source repository and update your index. If you don't set a schedule, Amazon
    /// Q Business won't periodically update the index.
    ///
    /// Specify a `cron-` format schedule string or an empty string to indicate that
    /// the index is updated on demand. You can't specify the `Schedule` parameter
    /// when the `Type` parameter is set to `CUSTOM`. If you do, you receive a
    /// `ValidationException` exception.
    sync_schedule: ?[]const u8 = null,

    /// A list of key-value pairs that identify or categorize the data source
    /// connector. You can also use tags to help control access to the data source
    /// connector. Tag keys and values can consist of Unicode letters, digits, white
    /// space, and any of the following symbols: _ . : / = + - @.
    tags: ?[]const Tag = null,

    /// Configuration information for an Amazon VPC (Virtual Private Cloud) to
    /// connect to your data source. For more information, see [Using Amazon VPC
    /// with Amazon Q Business
    /// connectors](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/connector-vpc.html).
    vpc_configuration: ?DataSourceVpcConfiguration = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .client_token = "clientToken",
        .configuration = "configuration",
        .description = "description",
        .display_name = "displayName",
        .document_enrichment_configuration = "documentEnrichmentConfiguration",
        .index_id = "indexId",
        .media_extraction_configuration = "mediaExtractionConfiguration",
        .role_arn = "roleArn",
        .sync_schedule = "syncSchedule",
        .tags = "tags",
        .vpc_configuration = "vpcConfiguration",
    };
};

pub const CreateDataSourceOutput = struct {
    /// The Amazon Resource Name (ARN) of a data source in an Amazon Q Business
    /// application.
    data_source_arn: ?[]const u8 = null,

    /// The identifier of the data source connector.
    data_source_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_arn = "dataSourceArn",
        .data_source_id = "dataSourceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataSourceInput, options: CallOptions) !CreateDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/indices/");
    try path_buf.appendSlice(allocator, input.index_id);
    try path_buf.appendSlice(allocator, "/datasources");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"displayName\":");
    try aws.json.writeValue(@TypeOf(input.display_name), input.display_name, allocator, &body_buf);
    has_prev = true;
    if (input.document_enrichment_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"documentEnrichmentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.media_extraction_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mediaExtractionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sync_schedule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"syncSchedule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataSourceOutput {
    var result: CreateDataSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDataSourceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
