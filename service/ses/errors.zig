const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        account_sending_paused_exception: AccountSendingPausedException,
        already_exists_exception: AlreadyExistsException,
        cannot_delete_exception: CannotDeleteException,
        configuration_set_already_exists_exception: ConfigurationSetAlreadyExistsException,
        configuration_set_does_not_exist_exception: ConfigurationSetDoesNotExistException,
        configuration_set_sending_paused_exception: ConfigurationSetSendingPausedException,
        custom_verification_email_invalid_content_exception: CustomVerificationEmailInvalidContentException,
        custom_verification_email_template_already_exists_exception: CustomVerificationEmailTemplateAlreadyExistsException,
        custom_verification_email_template_does_not_exist_exception: CustomVerificationEmailTemplateDoesNotExistException,
        event_destination_already_exists_exception: EventDestinationAlreadyExistsException,
        event_destination_does_not_exist_exception: EventDestinationDoesNotExistException,
        from_email_address_not_verified_exception: FromEmailAddressNotVerifiedException,
        invalid_cloud_watch_destination_exception: InvalidCloudWatchDestinationException,
        invalid_configuration_set_exception: InvalidConfigurationSetException,
        invalid_delivery_options_exception: InvalidDeliveryOptionsException,
        invalid_firehose_destination_exception: InvalidFirehoseDestinationException,
        invalid_lambda_function_exception: InvalidLambdaFunctionException,
        invalid_policy_exception: InvalidPolicyException,
        invalid_rendering_parameter_exception: InvalidRenderingParameterException,
        invalid_s3_configuration_exception: InvalidS3ConfigurationException,
        invalid_sns_destination_exception: InvalidSNSDestinationException,
        invalid_sns_topic_exception: InvalidSnsTopicException,
        invalid_template_exception: InvalidTemplateException,
        invalid_tracking_options_exception: InvalidTrackingOptionsException,
        limit_exceeded_exception: LimitExceededException,
        mail_from_domain_not_verified_exception: MailFromDomainNotVerifiedException,
        message_rejected: MessageRejected,
        missing_rendering_attribute_exception: MissingRenderingAttributeException,
        production_access_not_granted_exception: ProductionAccessNotGrantedException,
        rule_does_not_exist_exception: RuleDoesNotExistException,
        rule_set_does_not_exist_exception: RuleSetDoesNotExistException,
        template_does_not_exist_exception: TemplateDoesNotExistException,
        tracking_options_already_exists_exception: TrackingOptionsAlreadyExistsException,
        tracking_options_does_not_exist_exception: TrackingOptionsDoesNotExistException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .account_sending_paused_exception => "AccountSendingPausedException",
                .already_exists_exception => "AlreadyExistsException",
                .cannot_delete_exception => "CannotDeleteException",
                .configuration_set_already_exists_exception => "ConfigurationSetAlreadyExistsException",
                .configuration_set_does_not_exist_exception => "ConfigurationSetDoesNotExistException",
                .configuration_set_sending_paused_exception => "ConfigurationSetSendingPausedException",
                .custom_verification_email_invalid_content_exception => "CustomVerificationEmailInvalidContentException",
                .custom_verification_email_template_already_exists_exception => "CustomVerificationEmailTemplateAlreadyExistsException",
                .custom_verification_email_template_does_not_exist_exception => "CustomVerificationEmailTemplateDoesNotExistException",
                .event_destination_already_exists_exception => "EventDestinationAlreadyExistsException",
                .event_destination_does_not_exist_exception => "EventDestinationDoesNotExistException",
                .from_email_address_not_verified_exception => "FromEmailAddressNotVerifiedException",
                .invalid_cloud_watch_destination_exception => "InvalidCloudWatchDestinationException",
                .invalid_configuration_set_exception => "InvalidConfigurationSetException",
                .invalid_delivery_options_exception => "InvalidDeliveryOptionsException",
                .invalid_firehose_destination_exception => "InvalidFirehoseDestinationException",
                .invalid_lambda_function_exception => "InvalidLambdaFunctionException",
                .invalid_policy_exception => "InvalidPolicyException",
                .invalid_rendering_parameter_exception => "InvalidRenderingParameterException",
                .invalid_s3_configuration_exception => "InvalidS3ConfigurationException",
                .invalid_sns_destination_exception => "InvalidSNSDestinationException",
                .invalid_sns_topic_exception => "InvalidSnsTopicException",
                .invalid_template_exception => "InvalidTemplateException",
                .invalid_tracking_options_exception => "InvalidTrackingOptionsException",
                .limit_exceeded_exception => "LimitExceededException",
                .mail_from_domain_not_verified_exception => "MailFromDomainNotVerifiedException",
                .message_rejected => "MessageRejected",
                .missing_rendering_attribute_exception => "MissingRenderingAttributeException",
                .production_access_not_granted_exception => "ProductionAccessNotGrantedException",
                .rule_does_not_exist_exception => "RuleDoesNotExistException",
                .rule_set_does_not_exist_exception => "RuleSetDoesNotExistException",
                .template_does_not_exist_exception => "TemplateDoesNotExistException",
                .tracking_options_already_exists_exception => "TrackingOptionsAlreadyExistsException",
                .tracking_options_does_not_exist_exception => "TrackingOptionsDoesNotExistException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .account_sending_paused_exception => |e| e.message,
                .already_exists_exception => |e| e.message,
                .cannot_delete_exception => |e| e.message,
                .configuration_set_already_exists_exception => |e| e.message,
                .configuration_set_does_not_exist_exception => |e| e.message,
                .configuration_set_sending_paused_exception => |e| e.message,
                .custom_verification_email_invalid_content_exception => |e| e.message,
                .custom_verification_email_template_already_exists_exception => |e| e.message,
                .custom_verification_email_template_does_not_exist_exception => |e| e.message,
                .event_destination_already_exists_exception => |e| e.message,
                .event_destination_does_not_exist_exception => |e| e.message,
                .from_email_address_not_verified_exception => |e| e.message,
                .invalid_cloud_watch_destination_exception => |e| e.message,
                .invalid_configuration_set_exception => |e| e.message,
                .invalid_delivery_options_exception => |e| e.message,
                .invalid_firehose_destination_exception => |e| e.message,
                .invalid_lambda_function_exception => |e| e.message,
                .invalid_policy_exception => |e| e.message,
                .invalid_rendering_parameter_exception => |e| e.message,
                .invalid_s3_configuration_exception => |e| e.message,
                .invalid_sns_destination_exception => |e| e.message,
                .invalid_sns_topic_exception => |e| e.message,
                .invalid_template_exception => |e| e.message,
                .invalid_tracking_options_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .mail_from_domain_not_verified_exception => |e| e.message,
                .message_rejected => |e| e.message,
                .missing_rendering_attribute_exception => |e| e.message,
                .production_access_not_granted_exception => |e| e.message,
                .rule_does_not_exist_exception => |e| e.message,
                .rule_set_does_not_exist_exception => |e| e.message,
                .template_does_not_exist_exception => |e| e.message,
                .tracking_options_already_exists_exception => |e| e.message,
                .tracking_options_does_not_exist_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .account_sending_paused_exception => 400,
                .already_exists_exception => 400,
                .cannot_delete_exception => 400,
                .configuration_set_already_exists_exception => 400,
                .configuration_set_does_not_exist_exception => 400,
                .configuration_set_sending_paused_exception => 400,
                .custom_verification_email_invalid_content_exception => 400,
                .custom_verification_email_template_already_exists_exception => 400,
                .custom_verification_email_template_does_not_exist_exception => 400,
                .event_destination_already_exists_exception => 400,
                .event_destination_does_not_exist_exception => 400,
                .from_email_address_not_verified_exception => 400,
                .invalid_cloud_watch_destination_exception => 400,
                .invalid_configuration_set_exception => 400,
                .invalid_delivery_options_exception => 400,
                .invalid_firehose_destination_exception => 400,
                .invalid_lambda_function_exception => 400,
                .invalid_policy_exception => 400,
                .invalid_rendering_parameter_exception => 400,
                .invalid_s3_configuration_exception => 400,
                .invalid_sns_destination_exception => 400,
                .invalid_sns_topic_exception => 400,
                .invalid_template_exception => 400,
                .invalid_tracking_options_exception => 400,
                .limit_exceeded_exception => 400,
                .mail_from_domain_not_verified_exception => 400,
                .message_rejected => 400,
                .missing_rendering_attribute_exception => 400,
                .production_access_not_granted_exception => 400,
                .rule_does_not_exist_exception => 400,
                .rule_set_does_not_exist_exception => 400,
                .template_does_not_exist_exception => 400,
                .tracking_options_already_exists_exception => 400,
                .tracking_options_does_not_exist_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .account_sending_paused_exception => |e| e.request_id,
                .already_exists_exception => |e| e.request_id,
                .cannot_delete_exception => |e| e.request_id,
                .configuration_set_already_exists_exception => |e| e.request_id,
                .configuration_set_does_not_exist_exception => |e| e.request_id,
                .configuration_set_sending_paused_exception => |e| e.request_id,
                .custom_verification_email_invalid_content_exception => |e| e.request_id,
                .custom_verification_email_template_already_exists_exception => |e| e.request_id,
                .custom_verification_email_template_does_not_exist_exception => |e| e.request_id,
                .event_destination_already_exists_exception => |e| e.request_id,
                .event_destination_does_not_exist_exception => |e| e.request_id,
                .from_email_address_not_verified_exception => |e| e.request_id,
                .invalid_cloud_watch_destination_exception => |e| e.request_id,
                .invalid_configuration_set_exception => |e| e.request_id,
                .invalid_delivery_options_exception => |e| e.request_id,
                .invalid_firehose_destination_exception => |e| e.request_id,
                .invalid_lambda_function_exception => |e| e.request_id,
                .invalid_policy_exception => |e| e.request_id,
                .invalid_rendering_parameter_exception => |e| e.request_id,
                .invalid_s3_configuration_exception => |e| e.request_id,
                .invalid_sns_destination_exception => |e| e.request_id,
                .invalid_sns_topic_exception => |e| e.request_id,
                .invalid_template_exception => |e| e.request_id,
                .invalid_tracking_options_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .mail_from_domain_not_verified_exception => |e| e.request_id,
                .message_rejected => |e| e.request_id,
                .missing_rendering_attribute_exception => |e| e.request_id,
                .production_access_not_granted_exception => |e| e.request_id,
                .rule_does_not_exist_exception => |e| e.request_id,
                .rule_set_does_not_exist_exception => |e| e.request_id,
                .template_does_not_exist_exception => |e| e.request_id,
                .tracking_options_already_exists_exception => |e| e.request_id,
                .tracking_options_does_not_exist_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

pub const AccountSendingPausedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CannotDeleteException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConfigurationSetAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConfigurationSetDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConfigurationSetSendingPausedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomVerificationEmailInvalidContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomVerificationEmailTemplateAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomVerificationEmailTemplateDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventDestinationAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventDestinationDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FromEmailAddressNotVerifiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCloudWatchDestinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidConfigurationSetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeliveryOptionsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFirehoseDestinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLambdaFunctionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRenderingParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3ConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSNSDestinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSnsTopicException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTemplateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTrackingOptionsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MailFromDomainNotVerifiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MessageRejected = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingRenderingAttributeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ProductionAccessNotGrantedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RuleDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RuleSetDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TemplateDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrackingOptionsAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrackingOptionsDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
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
