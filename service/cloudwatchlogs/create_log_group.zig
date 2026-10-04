const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogGroupClass = @import("log_group_class.zig").LogGroupClass;

pub const CreateLogGroupInput = struct {
    /// Use this parameter to enable deletion protection for the new log group. When
    /// enabled on
    /// a log group, deletion protection blocks all deletion operations until it is
    /// explicitly
    /// disabled. By default log groups are created without deletion protection
    /// enabled.
    deletion_protection_enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the KMS key to use when encrypting log
    /// data. For more information, see [Amazon Resource
    /// Names](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kms).
    kms_key_id: ?[]const u8 = null,

    /// Use this parameter to specify the log group class for this log group. There
    /// are three
    /// classes:
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
    /// If you omit this parameter, the default of `STANDARD` is used.
    ///
    /// The value of `logGroupClass` can't be changed after a log group is
    /// created.
    ///
    /// For details about the features supported by each class, see [Log
    /// classes](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch_Logs_Log_Classes.html)
    log_group_class: ?LogGroupClass = null,

    /// A name for the log group.
    log_group_name: []const u8,

    /// The key-value pairs to use for the tags.
    ///
    /// You can grant users access to certain log groups while preventing them from
    /// accessing
    /// other log groups. To do so, tag your groups and use IAM policies that refer
    /// to
    /// those tags. To assign tags when you create a log group, you must have either
    /// the
    /// `logs:TagResource` or `logs:TagLogGroup` permission. For more
    /// information about tagging, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    /// For
    /// more information about using tags to control access, see [Controlling access
    /// to Amazon Web Services
    /// resources using
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .deletion_protection_enabled = "deletionProtectionEnabled",
        .kms_key_id = "kmsKeyId",
        .log_group_class = "logGroupClass",
        .log_group_name = "logGroupName",
        .tags = "tags",
    };
};

pub const CreateLogGroupOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLogGroupInput, options: CallOptions) !CreateLogGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLogGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.CreateLogGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLogGroupOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
