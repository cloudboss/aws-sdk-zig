const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MailboxExportJob = @import("mailbox_export_job.zig").MailboxExportJob;

pub const ListMailboxExportJobsInput = struct {
    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// The token to use to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// The organization ID.
    organization_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .organization_id = "OrganizationId",
    };
};

pub const ListMailboxExportJobsOutput = struct {
    /// The mailbox export job details.
    jobs: ?[]const MailboxExportJob = null,

    /// The token to use to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .jobs = "Jobs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMailboxExportJobsInput, options: CallOptions) !ListMailboxExportJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMailboxExportJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.ListMailboxExportJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMailboxExportJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMailboxExportJobsOutput, body, allocator);
}
