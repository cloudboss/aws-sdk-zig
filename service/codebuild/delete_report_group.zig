const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteReportGroupInput = struct {
    /// The ARN of the report group to delete.
    arn: []const u8,

    /// If `true`, deletes any reports that belong to a report group before deleting
    /// the report group.
    ///
    /// If `false`, you must delete any reports in the report group. Use
    /// [ListReportsForReportGroup](https://docs.aws.amazon.com/codebuild/latest/APIReference/API_ListReportsForReportGroup.html) to get the reports in a report group. Use [DeleteReport](https://docs.aws.amazon.com/codebuild/latest/APIReference/API_DeleteReport.html) to delete the reports. If you call
    /// `DeleteReportGroup` for a report group that contains one or more reports,
    /// an exception is thrown.
    delete_reports: ?bool = null,

    pub const json_field_names = .{
        .arn = "arn",
        .delete_reports = "deleteReports",
    };
};

pub const DeleteReportGroupOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteReportGroupInput, options: CallOptions) !DeleteReportGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteReportGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.DeleteReportGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteReportGroupOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
