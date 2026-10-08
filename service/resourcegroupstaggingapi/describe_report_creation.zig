const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeReportCreationInput = struct {};

pub const DescribeReportCreationOutput = struct {
    /// Details of the common errors that all operations return.
    error_message: ?[]const u8 = null,

    /// The path to the Amazon S3 bucket where the report was stored on creation.
    s3_location: ?[]const u8 = null,

    /// The date and time that the report was started.
    start_date: ?[]const u8 = null,

    /// Reports the status of the operation.
    ///
    /// The operation status can be one of the following:
    ///
    /// * `RUNNING` - Report creation is in progress.
    ///
    /// * `SUCCEEDED` - Report creation is complete. You can open the report
    /// from the Amazon S3 bucket that you specified when you ran
    /// `StartReportCreation`.
    ///
    /// * `FAILED` - Report creation timed out or the Amazon S3 bucket is not
    /// accessible.
    ///
    /// * `NO REPORT` - No report was generated in the last 90 days.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .s3_location = "S3Location",
        .start_date = "StartDate",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReportCreationInput, options: CallOptions) !DescribeReportCreationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "tagging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReportCreationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("tagging", "Resource Groups Tagging API", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ResourceGroupsTaggingAPI_20170126.DescribeReportCreation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReportCreationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeReportCreationOutput, body, allocator);
}
