const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ExportableLambdaFunctionField = @import("exportable_lambda_function_field.zig").ExportableLambdaFunctionField;
const FileFormat = @import("file_format.zig").FileFormat;
const LambdaFunctionRecommendationFilter = @import("lambda_function_recommendation_filter.zig").LambdaFunctionRecommendationFilter;
const S3DestinationConfig = @import("s3_destination_config.zig").S3DestinationConfig;
const S3Destination = @import("s3_destination.zig").S3Destination;

pub const ExportLambdaFunctionRecommendationsInput = struct {
    /// The IDs of the Amazon Web Services accounts for which to export Lambda
    /// function recommendations.
    ///
    /// If your account is the management account of an organization, use this
    /// parameter to
    /// specify the member account for which you want to export recommendations.
    ///
    /// This parameter cannot be specified together with the include member accounts
    /// parameter. The parameters are mutually exclusive.
    ///
    /// Recommendations for member accounts are not included in the export if this
    /// parameter,
    /// or the include member accounts parameter, is omitted.
    ///
    /// You can specify multiple account IDs per request.
    account_ids: ?[]const []const u8 = null,

    /// The recommendations data to include in the export file. For more information
    /// about the
    /// fields that can be exported, see [Exported
    /// files](https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html#exported-files) in the *Compute Optimizer User
    /// Guide*.
    fields_to_export: ?[]const ExportableLambdaFunctionField = null,

    /// The format of the export file.
    ///
    /// The only export file format currently supported is `Csv`.
    file_format: ?FileFormat = null,

    /// An array of objects to specify a filter that exports a more specific set of
    /// Lambda function recommendations.
    filters: ?[]const LambdaFunctionRecommendationFilter = null,

    /// Indicates whether to include recommendations for resources in all member
    /// accounts of
    /// the organization if your account is the management account of an
    /// organization.
    ///
    /// The member accounts must also be opted in to Compute Optimizer, and trusted
    /// access for
    /// Compute Optimizer must be enabled in the organization account. For more
    /// information,
    /// see [Compute Optimizer and Amazon Web Services Organizations trusted
    /// access](https://docs.aws.amazon.com/compute-optimizer/latest/ug/security-iam.html#trusted-service-access) in the
    /// *Compute Optimizer User Guide*.
    ///
    /// Recommendations for member accounts of the organization are not included in
    /// the export
    /// file if this parameter is omitted.
    ///
    /// This parameter cannot be specified together with the account IDs parameter.
    /// The
    /// parameters are mutually exclusive.
    ///
    /// Recommendations for member accounts are not included in the export if this
    /// parameter,
    /// or the account IDs parameter, is omitted.
    include_member_accounts: ?bool = null,

    s_3_destination_config: S3DestinationConfig,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .fields_to_export = "fieldsToExport",
        .file_format = "fileFormat",
        .filters = "filters",
        .include_member_accounts = "includeMemberAccounts",
        .s_3_destination_config = "s3DestinationConfig",
    };
};

pub const ExportLambdaFunctionRecommendationsOutput = struct {
    /// The identification number of the export job.
    ///
    /// Use the DescribeRecommendationExportJobs action, and specify the job
    /// ID to view the status of an export job.
    job_id: ?[]const u8 = null,

    s_3_destination: ?S3Destination = null,

    pub const json_field_names = .{
        .job_id = "jobId",
        .s_3_destination = "s3Destination",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportLambdaFunctionRecommendationsInput, options: CallOptions) !ExportLambdaFunctionRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "compute-optimizer");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportLambdaFunctionRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("compute-optimizer", "Compute Optimizer", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.ExportLambdaFunctionRecommendations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportLambdaFunctionRecommendationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExportLambdaFunctionRecommendationsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingAuthenticationToken")) {
        return .{ .arena = arena, .kind = .{ .missing_authentication_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptInRequiredException")) {
        return .{ .arena = arena, .kind = .{ .opt_in_required_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
