const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ReceiptRule = @import("receipt_rule.zig").ReceiptRule;
const serde = @import("serde.zig");

pub const CreateReceiptRuleInput = struct {
    /// The name of an existing rule after which the new rule is placed. If this
    /// parameter is
    /// null, the new rule is inserted at the beginning of the rule list.
    after: ?[]const u8 = null,

    /// A data structure that contains the specified rule's name, actions,
    /// recipients,
    /// domains, enabled status, scan status, and TLS policy.
    rule: ReceiptRule,

    /// The name of the rule set where the receipt rule is added.
    rule_set_name: []const u8,
};

pub const CreateReceiptRuleOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReceiptRuleInput, options: CallOptions) !CreateReceiptRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ses");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReceiptRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateReceiptRule&Version=2010-12-01");
    if (input.after) |v| {
        try body_buf.appendSlice(allocator, "&After=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.BounceAction.StatusCode=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.status_code) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.BounceAction.TopicArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.topic_arn) |fv_2| {
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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.LambdaAction.InvocationType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.invocation_type) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.LambdaAction.TopicArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.topic_arn) |fv_2| {
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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.S3Action.IamRoleArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.iam_role_arn) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.S3Action.KmsKeyArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.kms_key_arn) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.S3Action.ObjectKeyPrefix=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.object_key_prefix) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.S3Action.TopicArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.topic_arn) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
            if (item.sns_action) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.SNSAction.Encoding=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.encoding) |fv_2| {
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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.StopAction.TopicArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.topic_arn) |fv_2| {
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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rule.Actions.member.{d}.WorkmailAction.TopicArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.topic_arn) |fv_2| {
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReceiptRuleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CreateReceiptRuleOutput = .{};

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AccountSendingPausedException")) {
        return .{ .arena = arena, .kind = .{ .account_sending_paused_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotDeleteException")) {
        return .{ .arena = arena, .kind = .{ .cannot_delete_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConfigurationSetAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .configuration_set_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConfigurationSetDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .configuration_set_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConfigurationSetSendingPausedException")) {
        return .{ .arena = arena, .kind = .{ .configuration_set_sending_paused_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomVerificationEmailInvalidContentException")) {
        return .{ .arena = arena, .kind = .{ .custom_verification_email_invalid_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomVerificationEmailTemplateAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .custom_verification_email_template_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomVerificationEmailTemplateDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .custom_verification_email_template_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDestinationAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .event_destination_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDestinationDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .event_destination_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FromEmailAddressNotVerifiedException")) {
        return .{ .arena = arena, .kind = .{ .from_email_address_not_verified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCloudWatchDestinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_cloud_watch_destination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationSetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_configuration_set_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeliveryOptionsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_delivery_options_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFirehoseDestinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_firehose_destination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLambdaFunctionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_lambda_function_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRenderingParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_rendering_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3ConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSNSDestinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sns_destination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSnsTopicException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sns_topic_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTemplateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_template_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTrackingOptionsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tracking_options_exception = .{
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
    if (std.mem.eql(u8, error_code, "MailFromDomainNotVerifiedException")) {
        return .{ .arena = arena, .kind = .{ .mail_from_domain_not_verified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MessageRejected")) {
        return .{ .arena = arena, .kind = .{ .message_rejected = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingRenderingAttributeException")) {
        return .{ .arena = arena, .kind = .{ .missing_rendering_attribute_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProductionAccessNotGrantedException")) {
        return .{ .arena = arena, .kind = .{ .production_access_not_granted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuleDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .rule_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuleSetDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .rule_set_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TemplateDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .template_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrackingOptionsAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .tracking_options_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrackingOptionsDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .tracking_options_does_not_exist_exception = .{
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
