const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BackupJobState = @import("backup_job_state.zig").BackupJobState;
const BackupJob = @import("backup_job.zig").BackupJob;

pub const ListBackupJobsInput = struct {
    /// The account ID to list the jobs from. Returns only backup jobs associated
    /// with the
    /// specified account ID.
    ///
    /// If used from an Organizations management account, passing `*` returns
    /// all jobs across the organization.
    by_account_id: ?[]const u8 = null,

    /// Returns only backup jobs that will be stored in the specified backup vault.
    /// Backup
    /// vaults are identified by names that are unique to the account used to create
    /// them and the
    /// Amazon Web Services Region where they are created.
    by_backup_vault_name: ?[]const u8 = null,

    /// Returns only backup jobs completed after a date expressed in Unix format and
    /// Coordinated
    /// Universal Time (UTC).
    by_complete_after: ?i64 = null,

    /// Returns only backup jobs completed before a date expressed in Unix format
    /// and
    /// Coordinated Universal Time (UTC).
    by_complete_before: ?i64 = null,

    /// Returns only backup jobs that were created after the specified date.
    by_created_after: ?i64 = null,

    /// Returns only backup jobs that were created before the specified date.
    by_created_before: ?i64 = null,

    /// This is an optional parameter that can be used to
    /// filter out jobs with a MessageCategory which matches the
    /// value you input.
    ///
    /// Example strings may include `AccessDenied`,
    /// `SUCCESS`, `AGGREGATE_ALL`, and
    /// `InvalidParameters`.
    ///
    /// View
    /// [Monitoring](https://docs.aws.amazon.com/aws-backup/latest/devguide/monitoring.html)
    ///
    /// The wildcard () returns count of all message categories.
    ///
    /// `AGGREGATE_ALL` aggregates job counts
    /// for all message categories and returns the sum.
    by_message_category: ?[]const u8 = null,

    /// This is a filter to list child (nested) jobs based on parent job ID.
    by_parent_job_id: ?[]const u8 = null,

    /// Returns only backup jobs that match the specified resource Amazon Resource
    /// Name
    /// (ARN).
    by_resource_arn: ?[]const u8 = null,

    /// Returns only backup jobs for the specified resources:
    ///
    /// * `Aurora` for Amazon Aurora
    ///
    /// * `CloudFormation` for CloudFormation
    ///
    /// * `DocumentDB` for Amazon DocumentDB (with MongoDB compatibility)
    ///
    /// * `DynamoDB` for Amazon DynamoDB
    ///
    /// * `EBS` for Amazon Elastic Block Store
    ///
    /// * `EC2` for Amazon Elastic Compute Cloud
    ///
    /// * `EFS` for Amazon Elastic File System
    ///
    /// * `FSx` for Amazon FSx
    ///
    /// * `Neptune` for Amazon Neptune
    ///
    /// * `RDS` for Amazon Relational Database Service
    ///
    /// * `Redshift` for Amazon Redshift
    ///
    /// * `S3` for Amazon Simple Storage Service (Amazon S3)
    ///
    /// * `SAP HANA on Amazon EC2` for SAP HANA databases
    /// on Amazon Elastic Compute Cloud instances
    ///
    /// * `Storage Gateway` for Storage Gateway
    ///
    /// * `Timestream` for Amazon Timestream
    ///
    /// * `VirtualMachine` for VMware virtual machines
    by_resource_type: ?[]const u8 = null,

    /// Returns only backup jobs that are in the specified state.
    ///
    /// `Completed with issues` is a status found only in the Backup
    /// console. For API, this status refers to jobs with a state of `COMPLETED` and
    /// a
    /// `MessageCategory` with a value other than `SUCCESS`; that is, the
    /// status is completed but comes with a status message.
    ///
    /// To obtain the job count for
    /// `Completed with issues`, run two GET requests, and subtract the second,
    /// smaller number:
    ///
    /// GET /backup-jobs/?state=COMPLETED
    ///
    /// GET /backup-jobs/?messageCategory=SUCCESS&state=COMPLETED
    by_state: ?BackupJobState = null,

    /// The maximum number of items to be returned.
    max_results: ?i32 = null,

    /// The next item following a partial list of returned items. For example, if a
    /// request is
    /// made to return `MaxResults` number of items, `NextToken` allows you
    /// to return more items in your list starting at the location pointed to by the
    /// next
    /// token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .by_account_id = "ByAccountId",
        .by_backup_vault_name = "ByBackupVaultName",
        .by_complete_after = "ByCompleteAfter",
        .by_complete_before = "ByCompleteBefore",
        .by_created_after = "ByCreatedAfter",
        .by_created_before = "ByCreatedBefore",
        .by_message_category = "ByMessageCategory",
        .by_parent_job_id = "ByParentJobId",
        .by_resource_arn = "ByResourceArn",
        .by_resource_type = "ByResourceType",
        .by_state = "ByState",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListBackupJobsOutput = struct {
    /// An array of structures containing metadata about your backup jobs returned
    /// in JSON
    /// format.
    backup_jobs: ?[]const BackupJob = null,

    /// The next item following a partial list of returned items. For example, if a
    /// request is
    /// made to return `MaxResults` number of items, `NextToken` allows you
    /// to return more items in your list starting at the location pointed to by the
    /// next
    /// token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_jobs = "BackupJobs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBackupJobsInput, options: CallOptions) !ListBackupJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "backup");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListBackupJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/backup-jobs";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.by_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "accountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.by_backup_vault_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "backupVaultName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.by_complete_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "completeAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.by_complete_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "completeBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.by_created_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "createdAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.by_created_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "createdBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.by_message_category) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "messageCategory=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.by_parent_job_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "parentJobId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.by_resource_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resourceArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.by_resource_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resourceType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.by_state) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "state=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBackupJobsOutput {
    var result: ListBackupJobsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListBackupJobsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyFailureException")) {
        return .{ .arena = arena, .kind = .{ .dependency_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .missing_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
