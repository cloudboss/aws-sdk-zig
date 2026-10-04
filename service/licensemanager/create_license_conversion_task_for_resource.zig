const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LicenseConversionContext = @import("license_conversion_context.zig").LicenseConversionContext;

pub const CreateLicenseConversionTaskForResourceInput = struct {
    /// Information that identifies the license type you are converting to. For the
    /// structure of the destination license, see [Convert a license type using the
    /// CLI
    /// ](https://docs.aws.amazon.com/license-manager/latest/userguide/conversion-procedures.html#conversion-cli) in the *License Manager User Guide*.
    destination_license_context: LicenseConversionContext,

    /// Amazon Resource Name (ARN) of the resource you are converting the license
    /// type for.
    resource_arn: []const u8,

    /// Information that identifies the license type you are converting from.
    ///
    /// For the structure of the source license, see [Convert a license type using
    /// the CLI
    /// ](https://docs.aws.amazon.com/license-manager/latest/userguide/conversion-procedures.html#conversion-cli) in the *License Manager User Guide*.
    source_license_context: LicenseConversionContext,

    pub const json_field_names = .{
        .destination_license_context = "DestinationLicenseContext",
        .resource_arn = "ResourceArn",
        .source_license_context = "SourceLicenseContext",
    };
};

pub const CreateLicenseConversionTaskForResourceOutput = struct {
    /// The ID of the created license type conversion task.
    license_conversion_task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .license_conversion_task_id = "LicenseConversionTaskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLicenseConversionTaskForResourceInput, options: CallOptions) !CreateLicenseConversionTaskForResourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLicenseConversionTaskForResourceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.CreateLicenseConversionTaskForResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLicenseConversionTaskForResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLicenseConversionTaskForResourceOutput, body, allocator);
}
