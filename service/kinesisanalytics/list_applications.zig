const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationSummary = @import("application_summary.zig").ApplicationSummary;

pub const ListApplicationsInput = struct {
    /// Name of the application to start the list with. When using pagination to
    /// retrieve the list, you don't need to specify this parameter in the first
    /// request. However, in subsequent requests, you add the last application name
    /// from the previous response to get the next page of applications.
    exclusive_start_application_name: ?[]const u8 = null,

    /// Maximum number of applications to list.
    limit: ?i32 = null,

    pub const json_field_names = .{
        .exclusive_start_application_name = "ExclusiveStartApplicationName",
        .limit = "Limit",
    };
};

pub const ListApplicationsOutput = struct {
    /// List of `ApplicationSummary` objects.
    application_summaries: ?[]const ApplicationSummary = null,

    /// Returns true if there are more applications to retrieve.
    has_more_applications: bool,

    pub const json_field_names = .{
        .application_summaries = "ApplicationSummaries",
        .has_more_applications = "HasMoreApplications",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListApplicationsInput, options: CallOptions) !ListApplicationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisanalytics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListApplicationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20150814.ListApplications");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListApplicationsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListApplicationsOutput, body, allocator);
}
