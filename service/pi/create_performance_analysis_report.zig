const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceType = @import("service_type.zig").ServiceType;
const Tag = @import("tag.zig").Tag;

pub const CreatePerformanceAnalysisReportInput = struct {
    /// The end time defined for the analysis report.
    end_time: i64,

    /// An immutable, Amazon Web Services Region-unique identifier for a data
    /// source. Performance Insights gathers metrics from
    /// this data source.
    ///
    /// To use an Amazon RDS instance as a data source, you specify its
    /// `DbiResourceId` value.
    /// For example, specify `db-ADECBTYHKTSAUMUZQYPDS2GW4A`.
    identifier: []const u8,

    /// The Amazon Web Services service for which Performance Insights will return
    /// metrics. Valid value is `RDS`.
    service_type: ServiceType,

    /// The start time defined for the analysis report.
    start_time: i64,

    /// The metadata assigned to the analysis report consisting of a key-value pair.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .identifier = "Identifier",
        .service_type = "ServiceType",
        .start_time = "StartTime",
        .tags = "Tags",
    };
};

pub const CreatePerformanceAnalysisReportOutput = struct {
    /// A unique identifier for the created analysis report.
    analysis_report_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_report_id = "AnalysisReportId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePerformanceAnalysisReportInput, options: CallOptions) !CreatePerformanceAnalysisReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pi", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePerformanceAnalysisReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pi", "PI", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PerformanceInsightsv20180227.CreatePerformanceAnalysisReport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePerformanceAnalysisReportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePerformanceAnalysisReportOutput, body, allocator);
}
