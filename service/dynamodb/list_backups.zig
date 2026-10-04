const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BackupTypeFilter = @import("backup_type_filter.zig").BackupTypeFilter;
const BackupSummary = @import("backup_summary.zig").BackupSummary;

pub const ListBackupsInput = struct {
    /// The backups from the table specified by `BackupType` are listed.
    ///
    /// Where `BackupType` can be:
    ///
    /// * `USER` - On-demand backup created by you. (The default setting if no
    /// other backup types are specified.)
    ///
    /// * `SYSTEM` - On-demand backup automatically created by DynamoDB.
    ///
    /// * `ALL` - All types of on-demand backups (USER and SYSTEM).
    backup_type: ?BackupTypeFilter = null,

    /// `LastEvaluatedBackupArn` is the Amazon Resource Name (ARN) of the backup
    /// last
    /// evaluated when the current page of results was returned, inclusive of the
    /// current page
    /// of results. This value may be specified as the `ExclusiveStartBackupArn` of
    /// a
    /// new `ListBackups` operation in order to fetch the next page of results.
    exclusive_start_backup_arn: ?[]const u8 = null,

    /// Maximum number of backups to return at once.
    limit: ?i32 = null,

    /// Lists the backups from the table specified in `TableName`. You can also
    /// provide the Amazon Resource Name (ARN) of the table in this parameter.
    table_name: ?[]const u8 = null,

    /// Only backups created after this time are listed. `TimeRangeLowerBound` is
    /// inclusive.
    time_range_lower_bound: ?i64 = null,

    /// Only backups created before this time are listed. `TimeRangeUpperBound` is
    /// exclusive.
    time_range_upper_bound: ?i64 = null,

    pub const json_field_names = .{
        .backup_type = "BackupType",
        .exclusive_start_backup_arn = "ExclusiveStartBackupArn",
        .limit = "Limit",
        .table_name = "TableName",
        .time_range_lower_bound = "TimeRangeLowerBound",
        .time_range_upper_bound = "TimeRangeUpperBound",
    };
};

pub const ListBackupsOutput = struct {
    /// List of `BackupSummary` objects.
    backup_summaries: ?[]const BackupSummary = null,

    /// The ARN of the backup last evaluated when the current page of results was
    /// returned,
    /// inclusive of the current page of results. This value may be specified as the
    /// `ExclusiveStartBackupArn` of a new `ListBackups` operation in
    /// order to fetch the next page of results.
    ///
    /// If `LastEvaluatedBackupArn` is empty, then the last page of results has
    /// been processed and there are no more results to be retrieved.
    ///
    /// If `LastEvaluatedBackupArn` is not empty, this may or may not indicate
    /// that there is more data to be returned. All results are guaranteed to have
    /// been returned
    /// if and only if no value for `LastEvaluatedBackupArn` is returned.
    last_evaluated_backup_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_summaries = "BackupSummaries",
        .last_evaluated_backup_arn = "LastEvaluatedBackupArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBackupsInput, options: CallOptions) !ListBackupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBackupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.ListBackups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBackupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListBackupsOutput, body, allocator);
}
