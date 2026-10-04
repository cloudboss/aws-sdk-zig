const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const ResourceImportStatusType = @import("resource_import_status_type.zig").ResourceImportStatusType;

pub const DescribeDraftAppVersionResourcesImportStatusInput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    pub const json_field_names = .{
        .app_arn = "appArn",
    };
};

pub const DescribeDraftAppVersionResourcesImportStatusOutput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    /// The version of the application.
    app_version: []const u8,

    /// List of errors that were encountered while importing resources.
    error_details: ?[]const ErrorDetail = null,

    /// The error message returned for the resource request.
    error_message: ?[]const u8 = null,

    /// Status of the action.
    status: ResourceImportStatusType,

    /// The time when the status last changed.
    status_change_time: i64,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_version = "appVersion",
        .error_details = "errorDetails",
        .error_message = "errorMessage",
        .status = "status",
        .status_change_time = "statusChangeTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDraftAppVersionResourcesImportStatusInput, options: CallOptions) !DescribeDraftAppVersionResourcesImportStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDraftAppVersionResourcesImportStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describe-draft-app-version-resources-import-status";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appArn\":");
    try aws.json.writeValue(@TypeOf(input.app_arn), input.app_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDraftAppVersionResourcesImportStatusOutput {
    const result: DescribeDraftAppVersionResourcesImportStatusOutput = try aws.json.parseJsonObject(
        DescribeDraftAppVersionResourcesImportStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
