const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EdiType = @import("edi_type.zig").EdiType;
const FileFormat = @import("file_format.zig").FileFormat;
const InputConversion = @import("input_conversion.zig").InputConversion;
const Mapping = @import("mapping.zig").Mapping;
const OutputConversion = @import("output_conversion.zig").OutputConversion;
const SampleDocuments = @import("sample_documents.zig").SampleDocuments;
const TransformerStatus = @import("transformer_status.zig").TransformerStatus;

pub const GetTransformerInput = struct {
    /// Specifies the system-assigned unique identifier for the transformer.
    transformer_id: []const u8,

    pub const json_field_names = .{
        .transformer_id = "transformerId",
    };
};

pub const GetTransformerOutput = struct {
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
    modified_at: ?i64 = null,

    /// Returns the name of the transformer, used to identify it.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTransformerInput, options: Options) !GetTransformerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "b2bi");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTransformerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("b2bi", "b2bi", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.GetTransformer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTransformerOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetTransformerOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
