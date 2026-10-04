const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LicenseConversionContext = @import("license_conversion_context.zig").LicenseConversionContext;
const LicenseConversionTaskStatus = @import("license_conversion_task_status.zig").LicenseConversionTaskStatus;

pub const GetLicenseConversionTaskInput = struct {
    /// ID of the license type conversion task to retrieve information on.
    license_conversion_task_id: []const u8,

    pub const json_field_names = .{
        .license_conversion_task_id = "LicenseConversionTaskId",
    };
};

pub const GetLicenseConversionTaskOutput = struct {
    /// Information about the license type converted to.
    destination_license_context: ?LicenseConversionContext = null,

    /// Time at which the license type conversion task was completed.
    end_time: ?i64 = null,

    /// ID of the license type conversion task.
    license_conversion_task_id: ?[]const u8 = null,

    /// Amount of time to complete the license type conversion.
    license_conversion_time: ?i64 = null,

    /// Amazon Resource Names (ARN) of the resources the license conversion task is
    /// associated with.
    resource_arn: ?[]const u8 = null,

    /// Information about the license type converted from.
    source_license_context: ?LicenseConversionContext = null,

    /// Time at which the license type conversion task was started .
    start_time: ?i64 = null,

    /// Status of the license type conversion task.
    status: ?LicenseConversionTaskStatus = null,

    /// The status message for the conversion task.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_license_context = "DestinationLicenseContext",
        .end_time = "EndTime",
        .license_conversion_task_id = "LicenseConversionTaskId",
        .license_conversion_time = "LicenseConversionTime",
        .resource_arn = "ResourceArn",
        .source_license_context = "SourceLicenseContext",
        .start_time = "StartTime",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLicenseConversionTaskInput, options: CallOptions) !GetLicenseConversionTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLicenseConversionTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager", "License Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.GetLicenseConversionTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLicenseConversionTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetLicenseConversionTaskOutput, body, allocator);
}
