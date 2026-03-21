const aws = @import("aws");
const std = @import("std");

const AddHeaderAction = @import("add_header_action.zig").AddHeaderAction;
const BehaviorOnMXFailure = @import("behavior_on_mx_failure.zig").BehaviorOnMXFailure;
const Body = @import("body.zig").Body;
const BounceAction = @import("bounce_action.zig").BounceAction;
const BounceType = @import("bounce_type.zig").BounceType;
const BouncedRecipientInfo = @import("bounced_recipient_info.zig").BouncedRecipientInfo;
const BulkEmailDestination = @import("bulk_email_destination.zig").BulkEmailDestination;
const BulkEmailDestinationStatus = @import("bulk_email_destination_status.zig").BulkEmailDestinationStatus;
const BulkEmailStatus = @import("bulk_email_status.zig").BulkEmailStatus;
const CloudWatchDestination = @import("cloud_watch_destination.zig").CloudWatchDestination;
const CloudWatchDimensionConfiguration = @import("cloud_watch_dimension_configuration.zig").CloudWatchDimensionConfiguration;
const ConfigurationSet = @import("configuration_set.zig").ConfigurationSet;
const ConfigurationSetAttribute = @import("configuration_set_attribute.zig").ConfigurationSetAttribute;
const ConnectAction = @import("connect_action.zig").ConnectAction;
const Content = @import("content.zig").Content;
const CustomMailFromStatus = @import("custom_mail_from_status.zig").CustomMailFromStatus;
const CustomVerificationEmailTemplate = @import("custom_verification_email_template.zig").CustomVerificationEmailTemplate;
const DeliveryOptions = @import("delivery_options.zig").DeliveryOptions;
const Destination = @import("destination.zig").Destination;
const DimensionValueSource = @import("dimension_value_source.zig").DimensionValueSource;
const DsnAction = @import("dsn_action.zig").DsnAction;
const EventDestination = @import("event_destination.zig").EventDestination;
const EventType = @import("event_type.zig").EventType;
const ExtensionField = @import("extension_field.zig").ExtensionField;
const IdentityDkimAttributes = @import("identity_dkim_attributes.zig").IdentityDkimAttributes;
const IdentityMailFromDomainAttributes = @import("identity_mail_from_domain_attributes.zig").IdentityMailFromDomainAttributes;
const IdentityNotificationAttributes = @import("identity_notification_attributes.zig").IdentityNotificationAttributes;
const IdentityVerificationAttributes = @import("identity_verification_attributes.zig").IdentityVerificationAttributes;
const InvocationType = @import("invocation_type.zig").InvocationType;
const KinesisFirehoseDestination = @import("kinesis_firehose_destination.zig").KinesisFirehoseDestination;
const LambdaAction = @import("lambda_action.zig").LambdaAction;
const Message = @import("message.zig").Message;
const MessageDsn = @import("message_dsn.zig").MessageDsn;
const MessageTag = @import("message_tag.zig").MessageTag;
const RawMessage = @import("raw_message.zig").RawMessage;
const ReceiptAction = @import("receipt_action.zig").ReceiptAction;
const ReceiptFilter = @import("receipt_filter.zig").ReceiptFilter;
const ReceiptFilterPolicy = @import("receipt_filter_policy.zig").ReceiptFilterPolicy;
const ReceiptIpFilter = @import("receipt_ip_filter.zig").ReceiptIpFilter;
const ReceiptRule = @import("receipt_rule.zig").ReceiptRule;
const ReceiptRuleSetMetadata = @import("receipt_rule_set_metadata.zig").ReceiptRuleSetMetadata;
const RecipientDsnFields = @import("recipient_dsn_fields.zig").RecipientDsnFields;
const ReputationOptions = @import("reputation_options.zig").ReputationOptions;
const S3Action = @import("s3_action.zig").S3Action;
const SNSAction = @import("sns_action.zig").SNSAction;
const SNSActionEncoding = @import("sns_action_encoding.zig").SNSActionEncoding;
const SNSDestination = @import("sns_destination.zig").SNSDestination;
const SendDataPoint = @import("send_data_point.zig").SendDataPoint;
const StopAction = @import("stop_action.zig").StopAction;
const StopScope = @import("stop_scope.zig").StopScope;
const Template = @import("template.zig").Template;
const TemplateMetadata = @import("template_metadata.zig").TemplateMetadata;
const TlsPolicy = @import("tls_policy.zig").TlsPolicy;
const TrackingOptions = @import("tracking_options.zig").TrackingOptions;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;
const WorkmailAction = @import("workmail_action.zig").WorkmailAction;

pub fn deserializeAddressList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeBulkEmailDestinationStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const BulkEmailDestinationStatus {
    var list: std.ArrayList(BulkEmailDestinationStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeBulkEmailDestinationStatus(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCloudWatchDimensionConfigurations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CloudWatchDimensionConfiguration {
    var list: std.ArrayList(CloudWatchDimensionConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCloudWatchDimensionConfiguration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeConfigurationSets(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ConfigurationSet {
    var list: std.ArrayList(ConfigurationSet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeConfigurationSet(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCustomVerificationEmailTemplates(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CustomVerificationEmailTemplate {
    var list: std.ArrayList(CustomVerificationEmailTemplate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCustomVerificationEmailTemplate(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEventDestinations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EventDestination {
    var list: std.ArrayList(EventDestination) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEventDestination(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEventTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EventType {
    var list: std.ArrayList(EventType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (EventType.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeIdentityList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePolicyNameList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReceiptActionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReceiptAction {
    var list: std.ArrayList(ReceiptAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReceiptAction(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReceiptFilterList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReceiptFilter {
    var list: std.ArrayList(ReceiptFilter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReceiptFilter(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReceiptRuleSetsLists(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReceiptRuleSetMetadata {
    var list: std.ArrayList(ReceiptRuleSetMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReceiptRuleSetMetadata(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReceiptRulesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReceiptRule {
    var list: std.ArrayList(ReceiptRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReceiptRule(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRecipientsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSendDataPointList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SendDataPoint {
    var list: std.ArrayList(SendDataPoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSendDataPoint(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTemplateMetadataList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TemplateMetadata {
    var list: std.ArrayList(TemplateMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTemplateMetadata(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeVerificationTokenList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDkimAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(IdentityDkimAttributes) {
    var list: std.ArrayList(aws.map.MapEntry(IdentityDkimAttributes)) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: IdentityDkimAttributes = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try deserializeIdentityDkimAttributes(allocator, reader);
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMailFromDomainAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(IdentityMailFromDomainAttributes) {
    var list: std.ArrayList(aws.map.MapEntry(IdentityMailFromDomainAttributes)) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: IdentityMailFromDomainAttributes = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try deserializeIdentityMailFromDomainAttributes(allocator, reader);
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeNotificationAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(IdentityNotificationAttributes) {
    var list: std.ArrayList(aws.map.MapEntry(IdentityNotificationAttributes)) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: IdentityNotificationAttributes = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try deserializeIdentityNotificationAttributes(allocator, reader);
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePolicyMap(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
    var list: std.ArrayList(aws.map.StringMapEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: []const u8 = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try allocator.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeVerificationAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(IdentityVerificationAttributes) {
    var list: std.ArrayList(aws.map.MapEntry(IdentityVerificationAttributes)) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: IdentityVerificationAttributes = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try deserializeIdentityVerificationAttributes(allocator, reader);
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAddHeaderAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AddHeaderAction {
    var result: AddHeaderAction = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HeaderName")) {
                    result.header_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HeaderValue")) {
                    result.header_value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeBounceAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BounceAction {
    var result: BounceAction = undefined;
    result.status_code = null;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Sender")) {
                    result.sender = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SmtpReplyCode")) {
                    result.smtp_reply_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusCode")) {
                    result.status_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeBulkEmailDestinationStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BulkEmailDestinationStatus {
    var result: BulkEmailDestinationStatus = undefined;
    result.@"error" = null;
    result.message_id = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Error")) {
                    result.@"error" = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MessageId")) {
                    result.message_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = BulkEmailStatus.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudWatchDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CloudWatchDestination {
    var result: CloudWatchDestination = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DimensionConfigurations")) {
                    result.dimension_configurations = try deserializeCloudWatchDimensionConfigurations(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudWatchDimensionConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CloudWatchDimensionConfiguration {
    var result: CloudWatchDimensionConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultDimensionValue")) {
                    result.default_dimension_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DimensionName")) {
                    result.dimension_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DimensionValueSource")) {
                    result.dimension_value_source = DimensionValueSource.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConfigurationSet(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConfigurationSet {
    var result: ConfigurationSet = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConnectAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConnectAction {
    var result: ConnectAction = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IAMRoleARN")) {
                    result.iam_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceARN")) {
                    result.instance_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCustomVerificationEmailTemplate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CustomVerificationEmailTemplate {
    var result: CustomVerificationEmailTemplate = undefined;
    result.failure_redirection_url = null;
    result.from_email_address = null;
    result.success_redirection_url = null;
    result.template_name = null;
    result.template_subject = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailureRedirectionURL")) {
                    result.failure_redirection_url = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FromEmailAddress")) {
                    result.from_email_address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SuccessRedirectionURL")) {
                    result.success_redirection_url = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateSubject")) {
                    result.template_subject = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDeliveryOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DeliveryOptions {
    _ = allocator;
    var result: DeliveryOptions = undefined;
    result.tls_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TlsPolicy")) {
                    result.tls_policy = TlsPolicy.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEventDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EventDestination {
    var result: EventDestination = undefined;
    result.cloud_watch_destination = null;
    result.enabled = false;
    result.kinesis_firehose_destination = null;
    result.sns_destination = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CloudWatchDestination")) {
                    result.cloud_watch_destination = try deserializeCloudWatchDestination(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KinesisFirehoseDestination")) {
                    result.kinesis_firehose_destination = try deserializeKinesisFirehoseDestination(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MatchingEventTypes")) {
                    result.matching_event_types = try deserializeEventTypes(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SNSDestination")) {
                    result.sns_destination = try deserializeSNSDestination(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIdentityDkimAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IdentityDkimAttributes {
    var result: IdentityDkimAttributes = undefined;
    result.dkim_tokens = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DkimEnabled")) {
                    result.dkim_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DkimTokens")) {
                    result.dkim_tokens = try deserializeVerificationTokenList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "DkimVerificationStatus")) {
                    result.dkim_verification_status = VerificationStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIdentityMailFromDomainAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IdentityMailFromDomainAttributes {
    var result: IdentityMailFromDomainAttributes = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BehaviorOnMXFailure")) {
                    result.behavior_on_mx_failure = BehaviorOnMXFailure.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "MailFromDomain")) {
                    result.mail_from_domain = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MailFromDomainStatus")) {
                    result.mail_from_domain_status = CustomMailFromStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIdentityNotificationAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IdentityNotificationAttributes {
    var result: IdentityNotificationAttributes = undefined;
    result.headers_in_bounce_notifications_enabled = false;
    result.headers_in_complaint_notifications_enabled = false;
    result.headers_in_delivery_notifications_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BounceTopic")) {
                    result.bounce_topic = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ComplaintTopic")) {
                    result.complaint_topic = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeliveryTopic")) {
                    result.delivery_topic = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ForwardingEnabled")) {
                    result.forwarding_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HeadersInBounceNotificationsEnabled")) {
                    result.headers_in_bounce_notifications_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HeadersInComplaintNotificationsEnabled")) {
                    result.headers_in_complaint_notifications_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HeadersInDeliveryNotificationsEnabled")) {
                    result.headers_in_delivery_notifications_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIdentityVerificationAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IdentityVerificationAttributes {
    var result: IdentityVerificationAttributes = undefined;
    result.verification_token = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "VerificationStatus")) {
                    result.verification_status = VerificationStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "VerificationToken")) {
                    result.verification_token = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKinesisFirehoseDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KinesisFirehoseDestination {
    var result: KinesisFirehoseDestination = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeliveryStreamARN")) {
                    result.delivery_stream_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMRoleARN")) {
                    result.iam_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLambdaAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LambdaAction {
    var result: LambdaAction = undefined;
    result.invocation_type = null;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FunctionArn")) {
                    result.function_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvocationType")) {
                    result.invocation_type = InvocationType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReceiptAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReceiptAction {
    var result: ReceiptAction = undefined;
    result.add_header_action = null;
    result.bounce_action = null;
    result.connect_action = null;
    result.lambda_action = null;
    result.s3_action = null;
    result.sns_action = null;
    result.stop_action = null;
    result.workmail_action = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AddHeaderAction")) {
                    result.add_header_action = try deserializeAddHeaderAction(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "BounceAction")) {
                    result.bounce_action = try deserializeBounceAction(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ConnectAction")) {
                    result.connect_action = try deserializeConnectAction(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LambdaAction")) {
                    result.lambda_action = try deserializeLambdaAction(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3Action")) {
                    result.s3_action = try deserializeS3Action(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SNSAction")) {
                    result.sns_action = try deserializeSNSAction(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StopAction")) {
                    result.stop_action = try deserializeStopAction(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "WorkmailAction")) {
                    result.workmail_action = try deserializeWorkmailAction(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReceiptFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReceiptFilter {
    var result: ReceiptFilter = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IpFilter")) {
                    result.ip_filter = try deserializeReceiptIpFilter(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReceiptIpFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReceiptIpFilter {
    var result: ReceiptIpFilter = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cidr")) {
                    result.cidr = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = ReceiptFilterPolicy.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReceiptRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReceiptRule {
    var result: ReceiptRule = undefined;
    result.actions = null;
    result.enabled = false;
    result.recipients = null;
    result.scan_enabled = false;
    result.tls_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Actions")) {
                    result.actions = try deserializeReceiptActionsList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Recipients")) {
                    result.recipients = try deserializeRecipientsList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ScanEnabled")) {
                    result.scan_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TlsPolicy")) {
                    result.tls_policy = TlsPolicy.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReceiptRuleSetMetadata(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReceiptRuleSetMetadata {
    var result: ReceiptRuleSetMetadata = undefined;
    result.created_timestamp = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedTimestamp")) {
                    result.created_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReputationOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReputationOptions {
    _ = allocator;
    var result: ReputationOptions = undefined;
    result.last_fresh_start = null;
    result.reputation_metrics_enabled = false;
    result.sending_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastFreshStart")) {
                    result.last_fresh_start = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ReputationMetricsEnabled")) {
                    result.reputation_metrics_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SendingEnabled")) {
                    result.sending_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3Action(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3Action {
    var result: S3Action = undefined;
    result.iam_role_arn = null;
    result.kms_key_arn = null;
    result.object_key_prefix = null;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BucketName")) {
                    result.bucket_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IamRoleArn")) {
                    result.iam_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyArn")) {
                    result.kms_key_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectKeyPrefix")) {
                    result.object_key_prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSNSAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SNSAction {
    var result: SNSAction = undefined;
    result.encoding = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Encoding")) {
                    result.encoding = SNSActionEncoding.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSNSDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SNSDestination {
    var result: SNSDestination = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TopicARN")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSendDataPoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SendDataPoint {
    _ = allocator;
    var result: SendDataPoint = undefined;
    result.bounces = 0;
    result.complaints = 0;
    result.delivery_attempts = 0;
    result.rejects = 0;
    result.timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bounces")) {
                    result.bounces = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Complaints")) {
                    result.complaints = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DeliveryAttempts")) {
                    result.delivery_attempts = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Rejects")) {
                    result.rejects = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStopAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StopAction {
    var result: StopAction = undefined;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Scope")) {
                    result.scope = StopScope.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTemplate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Template {
    var result: Template = undefined;
    result.html_part = null;
    result.subject_part = null;
    result.text_part = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HtmlPart")) {
                    result.html_part = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubjectPart")) {
                    result.subject_part = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TextPart")) {
                    result.text_part = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTemplateMetadata(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TemplateMetadata {
    var result: TemplateMetadata = undefined;
    result.created_timestamp = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedTimestamp")) {
                    result.created_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrackingOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrackingOptions {
    var result: TrackingOptions = undefined;
    result.custom_redirect_domain = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CustomRedirectDomain")) {
                    result.custom_redirect_domain = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeWorkmailAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !WorkmailAction {
    var result: WorkmailAction = undefined;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OrganizationArn")) {
                    result.organization_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeAddressList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeBouncedRecipientInfoList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const BouncedRecipientInfo, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeBouncedRecipientInfo(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeBulkEmailDestinationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const BulkEmailDestination, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeBulkEmailDestination(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeCloudWatchDimensionConfigurations(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CloudWatchDimensionConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeCloudWatchDimensionConfiguration(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeConfigurationSetAttributeList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ConfigurationSetAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEventTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EventType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeExtensionFieldList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ExtensionField, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeExtensionField(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeIdentityList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMessageTagList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MessageTag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeMessageTag(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializePolicyNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeReceiptActionsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ReceiptAction, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeReceiptAction(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeReceiptRuleNamesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRecipientsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAddHeaderAction(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AddHeaderAction) !void {
    try buf.appendSlice(allocator, "<HeaderName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.header_name);
    try buf.appendSlice(allocator, "</HeaderName>");
    try buf.appendSlice(allocator, "<HeaderValue>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.header_value);
    try buf.appendSlice(allocator, "</HeaderValue>");
}

pub fn serializeBody(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Body) !void {
    if (value.html) |v| {
        try buf.appendSlice(allocator, "<Html>");
        try serializeContent(allocator, buf, v);
        try buf.appendSlice(allocator, "</Html>");
    }
    if (value.text) |v| {
        try buf.appendSlice(allocator, "<Text>");
        try serializeContent(allocator, buf, v);
        try buf.appendSlice(allocator, "</Text>");
    }
}

pub fn serializeBounceAction(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BounceAction) !void {
    try buf.appendSlice(allocator, "<Message>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.message);
    try buf.appendSlice(allocator, "</Message>");
    try buf.appendSlice(allocator, "<Sender>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.sender);
    try buf.appendSlice(allocator, "</Sender>");
    try buf.appendSlice(allocator, "<SmtpReplyCode>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.smtp_reply_code);
    try buf.appendSlice(allocator, "</SmtpReplyCode>");
    if (value.status_code) |v| {
        try buf.appendSlice(allocator, "<StatusCode>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</StatusCode>");
    }
    if (value.topic_arn) |v| {
        try buf.appendSlice(allocator, "<TopicArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TopicArn>");
    }
}

pub fn serializeBouncedRecipientInfo(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BouncedRecipientInfo) !void {
    if (value.bounce_type) |v| {
        try buf.appendSlice(allocator, "<BounceType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</BounceType>");
    }
    try buf.appendSlice(allocator, "<Recipient>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.recipient);
    try buf.appendSlice(allocator, "</Recipient>");
    if (value.recipient_arn) |v| {
        try buf.appendSlice(allocator, "<RecipientArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RecipientArn>");
    }
    if (value.recipient_dsn_fields) |v| {
        try buf.appendSlice(allocator, "<RecipientDsnFields>");
        try serializeRecipientDsnFields(allocator, buf, v);
        try buf.appendSlice(allocator, "</RecipientDsnFields>");
    }
}

pub fn serializeBulkEmailDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BulkEmailDestination) !void {
    try buf.appendSlice(allocator, "<Destination>");
    try serializeDestination(allocator, buf, value.destination);
    try buf.appendSlice(allocator, "</Destination>");
    if (value.replacement_tags) |v| {
        try buf.appendSlice(allocator, "<ReplacementTags>");
        try serializeMessageTagList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</ReplacementTags>");
    }
    if (value.replacement_template_data) |v| {
        try buf.appendSlice(allocator, "<ReplacementTemplateData>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ReplacementTemplateData>");
    }
}

pub fn serializeCloudWatchDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudWatchDestination) !void {
    try buf.appendSlice(allocator, "<DimensionConfigurations>");
    try serializeCloudWatchDimensionConfigurations(allocator, buf, value.dimension_configurations, "member");
    try buf.appendSlice(allocator, "</DimensionConfigurations>");
}

pub fn serializeCloudWatchDimensionConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudWatchDimensionConfiguration) !void {
    try buf.appendSlice(allocator, "<DefaultDimensionValue>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.default_dimension_value);
    try buf.appendSlice(allocator, "</DefaultDimensionValue>");
    try buf.appendSlice(allocator, "<DimensionName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.dimension_name);
    try buf.appendSlice(allocator, "</DimensionName>");
    try buf.appendSlice(allocator, "<DimensionValueSource>");
    try buf.appendSlice(allocator, value.dimension_value_source.wireName());
    try buf.appendSlice(allocator, "</DimensionValueSource>");
}

pub fn serializeConfigurationSet(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConfigurationSet) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
}

pub fn serializeConnectAction(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectAction) !void {
    try buf.appendSlice(allocator, "<IAMRoleARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.iam_role_arn);
    try buf.appendSlice(allocator, "</IAMRoleARN>");
    try buf.appendSlice(allocator, "<InstanceARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.instance_arn);
    try buf.appendSlice(allocator, "</InstanceARN>");
}

pub fn serializeContent(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Content) !void {
    if (value.charset) |v| {
        try buf.appendSlice(allocator, "<Charset>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Charset>");
    }
    try buf.appendSlice(allocator, "<Data>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.data);
    try buf.appendSlice(allocator, "</Data>");
}

pub fn serializeDeliveryOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DeliveryOptions) !void {
    if (value.tls_policy) |v| {
        try buf.appendSlice(allocator, "<TlsPolicy>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</TlsPolicy>");
    }
}

pub fn serializeDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Destination) !void {
    if (value.bcc_addresses) |v| {
        try buf.appendSlice(allocator, "<BccAddresses>");
        try serializeAddressList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</BccAddresses>");
    }
    if (value.cc_addresses) |v| {
        try buf.appendSlice(allocator, "<CcAddresses>");
        try serializeAddressList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</CcAddresses>");
    }
    if (value.to_addresses) |v| {
        try buf.appendSlice(allocator, "<ToAddresses>");
        try serializeAddressList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</ToAddresses>");
    }
}

pub fn serializeEventDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: EventDestination) !void {
    if (value.cloud_watch_destination) |v| {
        try buf.appendSlice(allocator, "<CloudWatchDestination>");
        try serializeCloudWatchDestination(allocator, buf, v);
        try buf.appendSlice(allocator, "</CloudWatchDestination>");
    }
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.kinesis_firehose_destination) |v| {
        try buf.appendSlice(allocator, "<KinesisFirehoseDestination>");
        try serializeKinesisFirehoseDestination(allocator, buf, v);
        try buf.appendSlice(allocator, "</KinesisFirehoseDestination>");
    }
    try buf.appendSlice(allocator, "<MatchingEventTypes>");
    try serializeEventTypes(allocator, buf, value.matching_event_types, "member");
    try buf.appendSlice(allocator, "</MatchingEventTypes>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    if (value.sns_destination) |v| {
        try buf.appendSlice(allocator, "<SNSDestination>");
        try serializeSNSDestination(allocator, buf, v);
        try buf.appendSlice(allocator, "</SNSDestination>");
    }
}

pub fn serializeExtensionField(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ExtensionField) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeKinesisFirehoseDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: KinesisFirehoseDestination) !void {
    try buf.appendSlice(allocator, "<DeliveryStreamARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.delivery_stream_arn);
    try buf.appendSlice(allocator, "</DeliveryStreamARN>");
    try buf.appendSlice(allocator, "<IAMRoleARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.iam_role_arn);
    try buf.appendSlice(allocator, "</IAMRoleARN>");
}

pub fn serializeLambdaAction(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LambdaAction) !void {
    try buf.appendSlice(allocator, "<FunctionArn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.function_arn);
    try buf.appendSlice(allocator, "</FunctionArn>");
    if (value.invocation_type) |v| {
        try buf.appendSlice(allocator, "<InvocationType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</InvocationType>");
    }
    if (value.topic_arn) |v| {
        try buf.appendSlice(allocator, "<TopicArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TopicArn>");
    }
}

pub fn serializeMessage(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Message) !void {
    try buf.appendSlice(allocator, "<Body>");
    try serializeBody(allocator, buf, value.body);
    try buf.appendSlice(allocator, "</Body>");
    try buf.appendSlice(allocator, "<Subject>");
    try serializeContent(allocator, buf, value.subject);
    try buf.appendSlice(allocator, "</Subject>");
}

pub fn serializeMessageDsn(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MessageDsn) !void {
    if (value.arrival_date) |v| {
        try buf.appendSlice(allocator, "<ArrivalDate>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</ArrivalDate>");
    }
    if (value.extension_fields) |v| {
        try buf.appendSlice(allocator, "<ExtensionFields>");
        try serializeExtensionFieldList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</ExtensionFields>");
    }
    try buf.appendSlice(allocator, "<ReportingMta>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.reporting_mta);
    try buf.appendSlice(allocator, "</ReportingMta>");
}

pub fn serializeMessageTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MessageTag) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeRawMessage(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RawMessage) !void {
    _ = allocator;
    _ = buf;
    _ = value;
}

pub fn serializeReceiptAction(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReceiptAction) !void {
    if (value.add_header_action) |v| {
        try buf.appendSlice(allocator, "<AddHeaderAction>");
        try serializeAddHeaderAction(allocator, buf, v);
        try buf.appendSlice(allocator, "</AddHeaderAction>");
    }
    if (value.bounce_action) |v| {
        try buf.appendSlice(allocator, "<BounceAction>");
        try serializeBounceAction(allocator, buf, v);
        try buf.appendSlice(allocator, "</BounceAction>");
    }
    if (value.connect_action) |v| {
        try buf.appendSlice(allocator, "<ConnectAction>");
        try serializeConnectAction(allocator, buf, v);
        try buf.appendSlice(allocator, "</ConnectAction>");
    }
    if (value.lambda_action) |v| {
        try buf.appendSlice(allocator, "<LambdaAction>");
        try serializeLambdaAction(allocator, buf, v);
        try buf.appendSlice(allocator, "</LambdaAction>");
    }
    if (value.s3_action) |v| {
        try buf.appendSlice(allocator, "<S3Action>");
        try serializeS3Action(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3Action>");
    }
    if (value.sns_action) |v| {
        try buf.appendSlice(allocator, "<SNSAction>");
        try serializeSNSAction(allocator, buf, v);
        try buf.appendSlice(allocator, "</SNSAction>");
    }
    if (value.stop_action) |v| {
        try buf.appendSlice(allocator, "<StopAction>");
        try serializeStopAction(allocator, buf, v);
        try buf.appendSlice(allocator, "</StopAction>");
    }
    if (value.workmail_action) |v| {
        try buf.appendSlice(allocator, "<WorkmailAction>");
        try serializeWorkmailAction(allocator, buf, v);
        try buf.appendSlice(allocator, "</WorkmailAction>");
    }
}

pub fn serializeReceiptFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReceiptFilter) !void {
    try buf.appendSlice(allocator, "<IpFilter>");
    try serializeReceiptIpFilter(allocator, buf, value.ip_filter);
    try buf.appendSlice(allocator, "</IpFilter>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
}

pub fn serializeReceiptIpFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReceiptIpFilter) !void {
    try buf.appendSlice(allocator, "<Cidr>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.cidr);
    try buf.appendSlice(allocator, "</Cidr>");
    try buf.appendSlice(allocator, "<Policy>");
    try buf.appendSlice(allocator, value.policy.wireName());
    try buf.appendSlice(allocator, "</Policy>");
}

pub fn serializeReceiptRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReceiptRule) !void {
    if (value.actions) |v| {
        try buf.appendSlice(allocator, "<Actions>");
        try serializeReceiptActionsList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Actions>");
    }
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    if (value.recipients) |v| {
        try buf.appendSlice(allocator, "<Recipients>");
        try serializeRecipientsList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Recipients>");
    }
    try buf.appendSlice(allocator, "<ScanEnabled>");
    try buf.appendSlice(allocator, if (value.scan_enabled) "true" else "false");
    try buf.appendSlice(allocator, "</ScanEnabled>");
    if (value.tls_policy) |v| {
        try buf.appendSlice(allocator, "<TlsPolicy>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</TlsPolicy>");
    }
}

pub fn serializeRecipientDsnFields(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RecipientDsnFields) !void {
    try buf.appendSlice(allocator, "<Action>");
    try buf.appendSlice(allocator, value.action.wireName());
    try buf.appendSlice(allocator, "</Action>");
    if (value.diagnostic_code) |v| {
        try buf.appendSlice(allocator, "<DiagnosticCode>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DiagnosticCode>");
    }
    if (value.extension_fields) |v| {
        try buf.appendSlice(allocator, "<ExtensionFields>");
        try serializeExtensionFieldList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</ExtensionFields>");
    }
    if (value.final_recipient) |v| {
        try buf.appendSlice(allocator, "<FinalRecipient>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</FinalRecipient>");
    }
    if (value.last_attempt_date) |v| {
        try buf.appendSlice(allocator, "<LastAttemptDate>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</LastAttemptDate>");
    }
    if (value.remote_mta) |v| {
        try buf.appendSlice(allocator, "<RemoteMta>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RemoteMta>");
    }
    try buf.appendSlice(allocator, "<Status>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.status);
    try buf.appendSlice(allocator, "</Status>");
}

pub fn serializeS3Action(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Action) !void {
    try buf.appendSlice(allocator, "<BucketName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.bucket_name);
    try buf.appendSlice(allocator, "</BucketName>");
    if (value.iam_role_arn) |v| {
        try buf.appendSlice(allocator, "<IamRoleArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</IamRoleArn>");
    }
    if (value.kms_key_arn) |v| {
        try buf.appendSlice(allocator, "<KmsKeyArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</KmsKeyArn>");
    }
    if (value.object_key_prefix) |v| {
        try buf.appendSlice(allocator, "<ObjectKeyPrefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ObjectKeyPrefix>");
    }
    if (value.topic_arn) |v| {
        try buf.appendSlice(allocator, "<TopicArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TopicArn>");
    }
}

pub fn serializeSNSAction(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SNSAction) !void {
    if (value.encoding) |v| {
        try buf.appendSlice(allocator, "<Encoding>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Encoding>");
    }
    try buf.appendSlice(allocator, "<TopicArn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.topic_arn);
    try buf.appendSlice(allocator, "</TopicArn>");
}

pub fn serializeSNSDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SNSDestination) !void {
    try buf.appendSlice(allocator, "<TopicARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.topic_arn);
    try buf.appendSlice(allocator, "</TopicARN>");
}

pub fn serializeStopAction(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StopAction) !void {
    try buf.appendSlice(allocator, "<Scope>");
    try buf.appendSlice(allocator, value.scope.wireName());
    try buf.appendSlice(allocator, "</Scope>");
    if (value.topic_arn) |v| {
        try buf.appendSlice(allocator, "<TopicArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TopicArn>");
    }
}

pub fn serializeTemplate(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Template) !void {
    if (value.html_part) |v| {
        try buf.appendSlice(allocator, "<HtmlPart>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</HtmlPart>");
    }
    if (value.subject_part) |v| {
        try buf.appendSlice(allocator, "<SubjectPart>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SubjectPart>");
    }
    try buf.appendSlice(allocator, "<TemplateName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.template_name);
    try buf.appendSlice(allocator, "</TemplateName>");
    if (value.text_part) |v| {
        try buf.appendSlice(allocator, "<TextPart>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TextPart>");
    }
}

pub fn serializeTrackingOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrackingOptions) !void {
    if (value.custom_redirect_domain) |v| {
        try buf.appendSlice(allocator, "<CustomRedirectDomain>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</CustomRedirectDomain>");
    }
}

pub fn serializeWorkmailAction(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: WorkmailAction) !void {
    try buf.appendSlice(allocator, "<OrganizationArn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.organization_arn);
    try buf.appendSlice(allocator, "</OrganizationArn>");
    if (value.topic_arn) |v| {
        try buf.appendSlice(allocator, "<TopicArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TopicArn>");
    }
}

