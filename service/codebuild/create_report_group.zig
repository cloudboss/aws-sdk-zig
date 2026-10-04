const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportExportConfig = @import("report_export_config.zig").ReportExportConfig;
const Tag = @import("tag.zig").Tag;
const ReportType = @import("report_type.zig").ReportType;
const ReportGroup = @import("report_group.zig").ReportGroup;

pub const CreateReportGroupInput = struct {
    /// A `ReportExportConfig` object that contains information about where the
    /// report group test results are exported.
    export_config: ReportExportConfig,

    /// The name of the report group.
    name: []const u8,

    /// A list of tag key and value pairs associated with this report group.
    ///
    /// These tags are available for use by Amazon Web Services services that
    /// support CodeBuild report group
    /// tags.
    tags: ?[]const Tag = null,

    /// The type of report group.
    @"type": ReportType,

    pub const json_field_names = .{
        .export_config = "exportConfig",
        .name = "name",
        .tags = "tags",
        .@"type" = "type",
    };
};

pub const CreateReportGroupOutput = struct {
    /// Information about the report group that was created.
    report_group: ?ReportGroup = null,

    pub const json_field_names = .{
        .report_group = "reportGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReportGroupInput, options: CallOptions) !CreateReportGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReportGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.CreateReportGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReportGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateReportGroupOutput, body, allocator);
}
