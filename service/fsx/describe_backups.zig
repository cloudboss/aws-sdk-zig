const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const Backup = @import("backup.zig").Backup;

pub const DescribeBackupsInput = struct {
    /// The IDs of the backups that you want to retrieve. This parameter value
    /// overrides any
    /// filters. If any IDs aren't found, a `BackupNotFound` error occurs.
    backup_ids: ?[]const []const u8 = null,

    /// The filters structure. The supported names are `file-system-id`,
    /// `backup-type`, `file-system-type`, and
    /// `volume-id`.
    filters: ?[]const Filter = null,

    /// Maximum number of backups to return in the response. This parameter value
    /// must be
    /// greater than 0. The number of items that Amazon FSx returns is the minimum
    /// of
    /// the `MaxResults` parameter specified in the request and the service's
    /// internal maximum number of items per page.
    max_results: ?i32 = null,

    /// An opaque pagination token returned from a previous `DescribeBackups`
    /// operation. If a token is present, the operation continues the list from
    /// where the
    /// returning call left off.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_ids = "BackupIds",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeBackupsOutput = struct {
    /// An array of backups.
    backups: ?[]const Backup = null,

    /// A `NextToken` value is present if there are more backups than returned in
    /// the response. You can use the `NextToken` value in the subsequent request to
    /// fetch the backups.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .backups = "Backups",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBackupsInput, options: CallOptions) !DescribeBackupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBackupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DescribeBackups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBackupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeBackupsOutput, body, allocator);
}
