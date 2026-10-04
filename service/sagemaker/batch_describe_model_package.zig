const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchDescribeModelPackageError = @import("batch_describe_model_package_error.zig").BatchDescribeModelPackageError;
const BatchDescribeModelPackageSummary = @import("batch_describe_model_package_summary.zig").BatchDescribeModelPackageSummary;

pub const BatchDescribeModelPackageInput = struct {
    /// The list of Amazon Resource Name (ARN) of the model package groups.
    model_package_arn_list: []const []const u8,

    pub const json_field_names = .{
        .model_package_arn_list = "ModelPackageArnList",
    };
};

pub const BatchDescribeModelPackageOutput = struct {
    /// A map of the resource and BatchDescribeModelPackageError objects reporting
    /// the error associated with describing the model package.
    batch_describe_model_package_error_map: ?[]const aws.map.MapEntry(BatchDescribeModelPackageError) = null,

    /// The summaries for the model package versions
    model_package_summaries: ?[]const aws.map.MapEntry(BatchDescribeModelPackageSummary) = null,

    pub const json_field_names = .{
        .batch_describe_model_package_error_map = "BatchDescribeModelPackageErrorMap",
        .model_package_summaries = "ModelPackageSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDescribeModelPackageInput, options: CallOptions) !BatchDescribeModelPackageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDescribeModelPackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.BatchDescribeModelPackage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDescribeModelPackageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchDescribeModelPackageOutput, body, allocator);
}
