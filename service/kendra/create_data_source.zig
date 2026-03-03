const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const CustomDocumentEnrichmentConfiguration = @import("custom_document_enrichment_configuration.zig").CustomDocumentEnrichmentConfiguration;
const Tag = @import("tag.zig").Tag;
const DataSourceType = @import("data_source_type.zig").DataSourceType;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

pub const CreateDataSourceInput = struct {
    /// A token that you provide to identify the request to create a data source
    /// connector.
    /// Multiple calls to the `CreateDataSource` API with the same client token will
    /// create
    /// only one data source connector.
    client_token: ?[]const u8 = null,

    /// Configuration information to connect to your data source repository.
    ///
    /// You can't specify the `Configuration` parameter when the `Type`
    /// parameter is set to `CUSTOM`. If you do, you receive a
    /// `ValidationException` exception.
    ///
    /// The `Configuration` parameter is required for all other data sources.
    configuration: ?DataSourceConfiguration = null,

    /// Configuration information for altering document metadata and content during
    /// the
    /// document ingestion process.
    ///
    /// For more information on how to create, modify and delete document metadata,
    /// or make
    /// other content alterations when you ingest documents into Amazon Kendra, see
    /// [Customizing document metadata during the ingestion
    /// process](https://docs.aws.amazon.com/kendra/latest/dg/custom-document-enrichment.html).
    custom_document_enrichment_configuration: ?CustomDocumentEnrichmentConfiguration = null,

    /// A description for the data source connector.
    description: ?[]const u8 = null,

    /// The identifier of the index you want to use with the data source connector.
    index_id: []const u8,

    /// The code for a language. This allows you to support a language for all
    /// documents when creating the data source connector. English is supported
    /// by default. For more information on supported languages, including their
    /// codes,
    /// see [Adding
    /// documents in languages other than
    /// English](https://docs.aws.amazon.com/kendra/latest/dg/in-adding-languages.html).
    language_code: ?[]const u8 = null,

    /// A name for the data source connector.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to access
    /// the data source and required resources. For more information, see [IAM
    /// access roles for Amazon
    /// Kendra.](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
    ///
    /// You can't specify the `RoleArn` parameter when the `Type` parameter
    /// is set to `CUSTOM`. If you do, you receive a `ValidationException`
    /// exception.
    ///
    /// The `RoleArn` parameter is required for all other data sources.
    role_arn: ?[]const u8 = null,

    /// Sets the frequency for Amazon Kendra to check the documents in your data
    /// source
    /// repository and update the index. If you don't set a schedule Amazon Kendra
    /// will not
    /// periodically update the index. You can call the `StartDataSourceSyncJob` API
    /// to
    /// update the index.
    ///
    /// Specify a `cron-` format schedule string or an empty string to indicate that
    /// the index is updated on demand.
    ///
    /// You can't specify the `Schedule` parameter when the `Type` parameter
    /// is set to `CUSTOM`. If you do, you receive a `ValidationException`
    /// exception.
    schedule: ?[]const u8 = null,

    /// A list of key-value pairs that identify or categorize the data source
    /// connector. You
    /// can also use tags to help control access to the data source connector. Tag
    /// keys and values
    /// can consist of Unicode letters, digits, white space, and any of the
    /// following symbols:
    /// _ . : / = + - @.
    tags: ?[]const Tag = null,

    /// The type of data source repository. For example, `SHAREPOINT`.
    @"type": DataSourceType,

    /// Configuration information for an Amazon Virtual Private Cloud to connect to
    /// your data source.
    /// For more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .configuration = "Configuration",
        .custom_document_enrichment_configuration = "CustomDocumentEnrichmentConfiguration",
        .description = "Description",
        .index_id = "IndexId",
        .language_code = "LanguageCode",
        .name = "Name",
        .role_arn = "RoleArn",
        .schedule = "Schedule",
        .tags = "Tags",
        .@"type" = "Type",
        .vpc_configuration = "VpcConfiguration",
    };
};

pub const CreateDataSourceOutput = struct {
    /// The identifier of the data source connector.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataSourceInput, options: Options) !CreateDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kendra");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.CreateDataSource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataSourceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateDataSourceOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FeaturedResultsConflictException")) {
        return .{ .arena = arena, .kind = .{ .featured_results_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
