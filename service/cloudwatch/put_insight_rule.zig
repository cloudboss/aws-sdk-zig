const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const PutInsightRuleInput = struct {
    /// Specify `true` to have this rule evaluate log events after they have been
    /// transformed by [Log
    /// transformation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html). If you specify `true`, then the log events in log
    /// groups that have transformers will be evaluated by Contributor Insights
    /// after being
    /// transformed. Log groups that don't have transformers will still have their
    /// original log
    /// events evaluated by Contributor Insights.
    ///
    /// The default is `false`
    ///
    /// If a log group has a transformer, and transformation fails for some log
    /// events,
    /// those log events won't be evaluated by Contributor Insights. For information
    /// about
    /// investigating log transformation failures, see [Transformation metrics and
    /// errors](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Transformation-Errors-Metrics.html).
    apply_on_transformed_logs: ?bool = null,

    /// The definition of the rule, as a JSON object. For details on the valid
    /// syntax, see
    /// [Contributor Insights Rule
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContributorInsights-RuleSyntax.html).
    rule_definition: []const u8,

    /// A unique name for the rule.
    rule_name: []const u8,

    /// The state of the rule. Valid values are ENABLED and DISABLED.
    rule_state: ?[]const u8 = null,

    /// A list of key-value pairs to associate with the Contributor Insights rule.
    /// You can
    /// associate as many as 50 tags with a rule.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to
    /// scope user permissions, by granting a user permission to access or change
    /// only the
    /// resources that have certain tag values.
    ///
    /// To be able to associate tags with a rule, you must have the
    /// `cloudwatch:TagResource` permission in addition to the
    /// `cloudwatch:PutInsightRule` permission.
    ///
    /// If you are using this operation to update an existing Contributor Insights
    /// rule, any
    /// tags you specify in this parameter are ignored. To change the tags of an
    /// existing rule,
    /// use
    /// [TagResource](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_TagResource.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .apply_on_transformed_logs = "ApplyOnTransformedLogs",
        .rule_definition = "RuleDefinition",
        .rule_name = "RuleName",
        .rule_state = "RuleState",
        .tags = "Tags",
    };
};

pub const PutInsightRuleOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutInsightRuleInput, options: CallOptions) !PutInsightRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutInsightRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PutInsightRule&Version=2010-08-01");
    if (input.apply_on_transformed_logs) |v| {
        try body_buf.appendSlice(allocator, "&ApplyOnTransformedLogs=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&RuleDefinition=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rule_definition);
    try body_buf.appendSlice(allocator, "&RuleName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rule_name);
    if (input.rule_state) |v| {
        try body_buf.appendSlice(allocator, "&RuleState=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutInsightRuleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutInsightRuleOutput = .{};

    return result;
}
