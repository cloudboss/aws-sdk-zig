const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const DataCatalogType = @import("data_catalog_type.zig").DataCatalogType;
const DataCatalog = @import("data_catalog.zig").DataCatalog;

pub const CreateDataCatalogInput = struct {
    /// A description of the data catalog to be created.
    description: ?[]const u8 = null,

    /// The name of the data catalog to create. The catalog name must be unique for
    /// the
    /// Amazon Web Services account and can use a maximum of 127 alphanumeric,
    /// underscore, at
    /// sign, or hyphen characters. The remainder of the length constraint of 256 is
    /// reserved
    /// for use by Athena.
    ///
    /// For `FEDERATED` type the catalog name has following considerations and
    /// limits:
    ///
    /// * The catalog name allows special characters such as `_ , @ , \ , -
    /// `. These characters are replaced with a hyphen (-) when creating the CFN
    /// Stack Name and with an underscore (_) when creating the Lambda Function and
    /// Glue
    /// Connection Name.
    ///
    /// * The catalog name has a theoretical limit of 128 characters. However, since
    ///   we
    /// use it to create other resources that allow less characters and we prepend a
    /// prefix to it, the actual catalog name limit for `FEDERATED` catalog
    /// is 64 - 23 = 41 characters.
    name: []const u8,

    /// Specifies the Lambda function or functions to use for creating the data
    /// catalog. This is a mapping whose values depend on the catalog type.
    ///
    /// * For the `HIVE` data catalog type, use the following syntax. The
    /// `metadata-function` parameter is required. `The
    /// sdk-version` parameter is optional and defaults to the currently
    /// supported version.
    ///
    /// `metadata-function=*lambda_arn*,
    /// sdk-version=*version_number*
    /// `
    ///
    /// * For the `LAMBDA` data catalog type, use one of the following sets
    /// of required parameters, but not both.
    ///
    /// * If you have one Lambda function that processes metadata
    /// and another for reading the actual data, use the following syntax. Both
    /// parameters are required.
    ///
    /// `metadata-function=*lambda_arn*,
    /// record-function=*lambda_arn*
    /// `
    ///
    /// * If you have a composite Lambda function that processes
    /// both metadata and data, use the following syntax to specify your Lambda
    /// function.
    ///
    /// `function=*lambda_arn*
    /// `
    ///
    /// * The `GLUE` type takes a catalog ID parameter and is required. The
    /// `
    /// *catalog_id*
    /// ` is the account ID of the
    /// Amazon Web Services account to which the Glue Data Catalog
    /// belongs.
    ///
    /// `catalog-id=*catalog_id*
    /// `
    ///
    /// * The `GLUE` data catalog type also applies to the default
    /// `AwsDataCatalog` that already exists in your account, of
    /// which you can have only one and cannot modify.
    ///
    /// * The `FEDERATED` data catalog type uses one of the following
    /// parameters, but not both. Use `connection-arn` for an existing
    /// Glue connection. Use `connection-type` and
    /// `connection-properties` to specify the configuration setting for
    /// a new connection.
    ///
    /// * `connection-arn:**
    /// `
    ///
    /// * `lambda-role-arn` (optional): The execution role to use for the
    /// Lambda function. If not provided, one is created.
    ///
    /// * `connection-type:MYSQL|REDSHIFT|....,
    /// connection-properties:"**"`
    ///
    /// For *
    /// ``
    /// *, use escaped
    /// JSON text, as in the following example.
    ///
    /// `"{\"spill_bucket\":\"my_spill\",\"spill_prefix\":\"athena-spill\",\"host\":\"abc12345.snowflakecomputing.com\",\"port\":\"1234\",\"warehouse\":\"DEV_WH\",\"database\":\"TEST\",\"schema\":\"PUBLIC\",\"SecretArn\":\"arn:aws:secretsmanager:ap-south-1:111122223333:secret:snowflake-XHb67j\"}"`
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// A list of comma separated tags to add to the data catalog that is created.
    /// All the
    /// resources that are created by the `CreateDataCatalog` API operation with
    /// `FEDERATED` type will have the tag
    /// `federated_athena_datacatalog="true"`. This includes the CFN Stack, Glue
    /// Connection, Athena DataCatalog, and all the resources created as part of the
    /// CFN Stack
    /// (Lambda Function, IAM policies/roles).
    tags: ?[]const Tag = null,

    /// The type of data catalog to create: `LAMBDA` for a federated catalog,
    /// `GLUE` for an Glue Data Catalog, and `HIVE` for an
    /// external Apache Hive metastore. `FEDERATED` is a federated catalog for which
    /// Athena creates the connection and the Lambda function for
    /// you based on the parameters that you pass.
    ///
    /// For `FEDERATED` type, we do not support IAM identity center.
    type: DataCatalogType,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .parameters = "Parameters",
        .tags = "Tags",
        .type = "Type",
    };
};

pub const CreateDataCatalogOutput = struct {
    data_catalog: ?DataCatalog = null,

    pub const json_field_names = .{
        .data_catalog = "DataCatalog",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataCatalogInput, options: Options) !CreateDataCatalogOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "athena");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDataCatalogInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonAthena.CreateDataCatalog");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDataCatalogOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDataCatalogOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

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
    if (std.mem.eql(u8, error_code, "MetadataException")) {
        return .{ .arena = arena, .kind = .{ .metadata_exception = .{
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
    if (std.mem.eql(u8, error_code, "SessionAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .session_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
