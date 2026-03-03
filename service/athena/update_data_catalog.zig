const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataCatalogType = @import("data_catalog_type.zig").DataCatalogType;

pub const UpdateDataCatalogInput = struct {
    /// New or modified text that describes the data catalog.
    description: ?[]const u8 = null,

    /// The name of the data catalog to update. The catalog name must be unique for
    /// the
    /// Amazon Web Services account and can use a maximum of 127 alphanumeric,
    /// underscore, at
    /// sign, or hyphen characters. The remainder of the length constraint of 256 is
    /// reserved
    /// for use by Athena.
    name: []const u8,

    /// Specifies the Lambda function or functions to use for updating the data
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
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the type of data catalog to update. Specify `LAMBDA` for a
    /// federated catalog, `HIVE` for an external hive metastore, or
    /// `GLUE` for an Glue Data Catalog.
    @"type": DataCatalogType,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .parameters = "Parameters",
        .@"type" = "Type",
    };
};

pub const UpdateDataCatalogOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataCatalogInput, options: Options) !UpdateDataCatalogOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataCatalogInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.UpdateDataCatalog");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataCatalogOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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
