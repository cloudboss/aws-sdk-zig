const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogGroupClass = @import("log_group_class.zig").LogGroupClass;
const LogGroup = @import("log_group.zig").LogGroup;

pub const DescribeLogGroupsInput = struct {
    /// When `includeLinkedAccounts` is set to `true`, use this parameter to
    /// specify the list of accounts to search. You can specify as many as 20
    /// account IDs in the
    /// array.
    account_identifiers: ?[]const []const u8 = null,

    /// If you are using a monitoring account, set this to `true` to have the
    /// operation
    /// return log groups in the accounts listed in `accountIdentifiers`.
    ///
    /// If this parameter is set to `true` and `accountIdentifiers` contains
    /// a null value, the operation returns all log groups in the monitoring account
    /// and all log
    /// groups in all source accounts that are linked to the monitoring account.
    ///
    /// The default for this parameter is `false`.
    include_linked_accounts: ?bool = null,

    /// The maximum number of items returned. If you don't specify a value, the
    /// default is up
    /// to 50 items.
    limit: ?i32 = null,

    /// Use this parameter to limit the results to only those log groups in the
    /// specified log
    /// group class. If you omit this parameter, log groups of all classes can be
    /// returned.
    ///
    /// Specifies the log group class for this log group. There are three classes:
    ///
    /// * The `Standard` log class supports all CloudWatch Logs features.
    ///
    /// * The `Infrequent Access` log class supports a subset of CloudWatch Logs
    /// features and incurs lower costs.
    ///
    /// * Use the `Delivery` log class only for delivering Lambda
    /// logs to store in Amazon S3 or Amazon Data Firehose. Log events in log groups
    /// in
    /// the Delivery class are kept in CloudWatch Logs for only one day. This log
    /// class doesn't
    /// offer rich CloudWatch Logs capabilities such as CloudWatch Logs Insights
    /// queries.
    ///
    /// For details about the features supported by each class, see [Log
    /// classes](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch_Logs_Log_Classes.html)
    log_group_class: ?LogGroupClass = null,

    /// Use this array to filter the list of log groups returned. If you specify
    /// this parameter,
    /// the only other filter that you can choose to specify is
    /// `includeLinkedAccounts`.
    ///
    /// If you are using this operation in a monitoring account, you can specify the
    /// ARNs of log
    /// groups in source accounts and in the monitoring account itself. If you are
    /// using this
    /// operation in an account that is not a cross-account monitoring account, you
    /// can specify only
    /// log group names in the same account as the operation.
    log_group_identifiers: ?[]const []const u8 = null,

    /// If you specify a string for this parameter, the operation returns only log
    /// groups that
    /// have names that match the string based on a case-sensitive substring search.
    /// For example, if
    /// you specify `DataLogs`, log groups named `DataLogs`,
    /// `aws/DataLogs`, and `GroupDataLogs` would match, but
    /// `datalogs`, `Data/log/s` and `Groupdata` would not
    /// match.
    ///
    /// If you specify `logGroupNamePattern` in your request, then only
    /// `arn`, `creationTime`, and `logGroupName` are included in
    /// the response.
    ///
    /// `logGroupNamePattern` and `logGroupNamePrefix` are mutually exclusive.
    /// Only one of these parameters can be passed.
    log_group_name_pattern: ?[]const u8 = null,

    /// The prefix to match.
    ///
    /// `logGroupNamePrefix` and `logGroupNamePattern` are mutually exclusive.
    /// Only one of these parameters can be passed.
    log_group_name_prefix: ?[]const u8 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_identifiers = "accountIdentifiers",
        .include_linked_accounts = "includeLinkedAccounts",
        .limit = "limit",
        .log_group_class = "logGroupClass",
        .log_group_identifiers = "logGroupIdentifiers",
        .log_group_name_pattern = "logGroupNamePattern",
        .log_group_name_prefix = "logGroupNamePrefix",
        .next_token = "nextToken",
    };
};

pub const DescribeLogGroupsOutput = struct {
    /// An array of structures, where each structure contains the information about
    /// one log
    /// group.
    log_groups: ?[]const LogGroup = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_groups = "logGroups",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLogGroupsInput, options: CallOptions) !DescribeLogGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLogGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeLogGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLogGroupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLogGroupsOutput, body, allocator);
}
