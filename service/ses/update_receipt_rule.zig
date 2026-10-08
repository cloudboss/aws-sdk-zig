const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReceiptRule = @import("receipt_rule.zig").ReceiptRule;
const serde = @import("serde.zig");

pub const UpdateReceiptRuleInput = struct {
    /// A data structure that contains the updated receipt rule information.
    rule: ReceiptRule,

    /// The name of the receipt rule set that the receipt rule belongs to.
    rule_set_name: []const u8,
};

pub const UpdateReceiptRuleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateReceiptRuleInput, options: CallOptions) !UpdateReceiptRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateReceiptRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateReceiptRule&Version=2010-12-01");
    if (input.rule.actions) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            if (item.add_header_action) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.AddHeaderAction.HeaderName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.header_name);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.AddHeaderAction.HeaderValue=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.header_value);
                }
            }
            if (item.bounce_action) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.BounceAction.Message=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.message);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.BounceAction.Sender=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.sender);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.BounceAction.SmtpReplyCode=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.smtp_reply_code);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.status_code) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.BounceAction.StatusCode=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.topic_arn) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.BounceAction.TopicArn=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
            if (item.connect_action) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.ConnectAction.IAMRoleARN=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.iam_role_arn);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.ConnectAction.InstanceARN=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.instance_arn);
                }
            }
            if (item.lambda_action) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.LambdaAction.FunctionArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.function_arn);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.invocation_type) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.LambdaAction.InvocationType=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.topic_arn) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.LambdaAction.TopicArn=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
            if (item.s3_action) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.S3Action.BucketName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.bucket_name);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.iam_role_arn) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.S3Action.IamRoleArn=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.kms_key_arn) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.S3Action.KmsKeyArn=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.object_key_prefix) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.S3Action.ObjectKeyPrefix=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.topic_arn) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.S3Action.TopicArn=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
            if (item.sns_action) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.encoding) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.SNSAction.Encoding=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.SNSAction.TopicArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.topic_arn);
                }
            }
            if (item.stop_action) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.StopAction.Scope=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.scope.wireName());
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.topic_arn) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.StopAction.TopicArn=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
            if (item.workmail_action) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.WorkmailAction.OrganizationArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.organization_arn);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.topic_arn) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.WorkmailAction.TopicArn=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
        }
    }
    if (input.rule.enabled) |sv| {
        try body_buf.appendSlice(allocator, "&Rule.Enabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&Rule.Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rule.name);
    if (input.rule.recipients) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Recipients.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.rule.scan_enabled) |sv| {
        try body_buf.appendSlice(allocator, "&Rule.ScanEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    if (input.rule.tls_policy) |sv| {
        try body_buf.appendSlice(allocator, "&Rule.TlsPolicy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    try body_buf.appendSlice(allocator, "&RuleSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rule_set_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateReceiptRuleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: UpdateReceiptRuleOutput = .{};

    return result;
}
