const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UsageReportSchedule = @import("usage_report_schedule.zig").UsageReportSchedule;

pub const CreateUsageReportSubscriptionInput = struct {};

pub const CreateUsageReportSubscriptionOutput = struct {
    /// The Amazon S3 bucket where generated reports are stored.
    ///
    /// If you enabled on-instance session scripts and Amazon S3 logging for your
    /// session script
    /// configuration, WorkSpaces Applications created an S3 bucket to store the
    /// script output. The bucket is
    /// unique to your account and Region. When you enable usage reporting in this
    /// case, WorkSpaces Applications
    /// uses the same bucket to store your usage reports. If you haven't already
    /// enabled on-instance session scripts,
    /// when you enable usage reports, WorkSpaces Applications creates a new S3
    /// bucket.
    s3_bucket_name: ?[]const u8 = null,

    /// The schedule for generating usage reports.
    schedule: ?UsageReportSchedule = null,

    pub const json_field_names = .{
        .s3_bucket_name = "S3BucketName",
        .schedule = "Schedule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUsageReportSubscriptionInput, options: CallOptions) !CreateUsageReportSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUsageReportSubscriptionInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateUsageReportSubscription");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUsageReportSubscriptionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateUsageReportSubscriptionOutput, body, allocator);
}
