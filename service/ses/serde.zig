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

pub fn deserializeAddressList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeBulkEmailDestinationStatusList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const BulkEmailDestinationStatus {
    var list: std.ArrayList(BulkEmailDestinationStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeBulkEmailDestinationStatus(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCloudWatchDimensionConfigurations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CloudWatchDimensionConfiguration {
    var list: std.ArrayList(CloudWatchDimensionConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCloudWatchDimensionConfiguration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeConfigurationSets(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ConfigurationSet {
    var list: std.ArrayList(ConfigurationSet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeConfigurationSet(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCustomVerificationEmailTemplates(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CustomVerificationEmailTemplate {
    var list: std.ArrayList(CustomVerificationEmailTemplate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCustomVerificationEmailTemplate(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEventDestinations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EventDestination {
    var list: std.ArrayList(EventDestination) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEventDestination(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEventTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EventType {
    var list: std.ArrayList(EventType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(EventType, try reader.readElementText())) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeIdentityList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePolicyNameList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReceiptActionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ReceiptAction {
    var list: std.ArrayList(ReceiptAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeReceiptAction(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReceiptFilterList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ReceiptFilter {
    var list: std.ArrayList(ReceiptFilter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeReceiptFilter(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReceiptRuleSetsLists(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ReceiptRuleSetMetadata {
    var list: std.ArrayList(ReceiptRuleSetMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeReceiptRuleSetMetadata(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReceiptRulesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ReceiptRule {
    var list: std.ArrayList(ReceiptRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeReceiptRule(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeRecipientsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSendDataPointList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SendDataPoint {
    var list: std.ArrayList(SendDataPoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSendDataPoint(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTemplateMetadataList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TemplateMetadata {
    var list: std.ArrayList(TemplateMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTemplateMetadata(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeVerificationTokenList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDkimAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(IdentityDkimAttributes) {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try deserializeIdentityDkimAttributes(reader, alloc);
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMailFromDomainAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(IdentityMailFromDomainAttributes) {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try deserializeIdentityMailFromDomainAttributes(reader, alloc);
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeNotificationAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(IdentityNotificationAttributes) {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try deserializeIdentityNotificationAttributes(reader, alloc);
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePolicyMap(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try alloc.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeVerificationAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(IdentityVerificationAttributes) {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try deserializeIdentityVerificationAttributes(reader, alloc);
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAddHeaderAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AddHeaderAction {
    var result: AddHeaderAction = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HeaderName")) {
                    result.header_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HeaderValue")) {
                    result.header_value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeBounceAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BounceAction {
    var result: BounceAction = undefined;
    result.status_code = null;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Sender")) {
                    result.sender = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SmtpReplyCode")) {
                    result.smtp_reply_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusCode")) {
                    result.status_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeBulkEmailDestinationStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BulkEmailDestinationStatus {
    var result: BulkEmailDestinationStatus = undefined;
    result.@"error" = null;
    result.message_id = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Error")) {
                    result.@"error" = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MessageId")) {
                    result.message_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(BulkEmailStatus, try reader.readElementText());
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

pub fn deserializeCloudWatchDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CloudWatchDestination {
    var result: CloudWatchDestination = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DimensionConfigurations")) {
                    result.dimension_configurations = try deserializeCloudWatchDimensionConfigurations(reader, alloc, "member");
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

pub fn deserializeCloudWatchDimensionConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CloudWatchDimensionConfiguration {
    var result: CloudWatchDimensionConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultDimensionValue")) {
                    result.default_dimension_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DimensionName")) {
                    result.dimension_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DimensionValueSource")) {
                    result.dimension_value_source = std.meta.stringToEnum(DimensionValueSource, try reader.readElementText());
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

pub fn deserializeConfigurationSet(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConfigurationSet {
    var result: ConfigurationSet = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeConnectAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConnectAction {
    var result: ConnectAction = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IAMRoleARN")) {
                    result.iam_role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceARN")) {
                    result.instance_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeCustomVerificationEmailTemplate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CustomVerificationEmailTemplate {
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
                    result.failure_redirection_url = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FromEmailAddress")) {
                    result.from_email_address = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SuccessRedirectionURL")) {
                    result.success_redirection_url = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateSubject")) {
                    result.template_subject = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDeliveryOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DeliveryOptions {
    _ = alloc;
    var result: DeliveryOptions = undefined;
    result.tls_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TlsPolicy")) {
                    result.tls_policy = std.meta.stringToEnum(TlsPolicy, try reader.readElementText());
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

pub fn deserializeEventDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EventDestination {
    var result: EventDestination = undefined;
    result.cloud_watch_destination = null;
    result.enabled = false;
    result.kinesis_firehose_destination = null;
    result.sns_destination = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CloudWatchDestination")) {
                    result.cloud_watch_destination = try deserializeCloudWatchDestination(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KinesisFirehoseDestination")) {
                    result.kinesis_firehose_destination = try deserializeKinesisFirehoseDestination(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MatchingEventTypes")) {
                    result.matching_event_types = try deserializeEventTypes(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SNSDestination")) {
                    result.sns_destination = try deserializeSNSDestination(reader, alloc);
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

pub fn deserializeIdentityDkimAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IdentityDkimAttributes {
    var result: IdentityDkimAttributes = undefined;
    result.dkim_tokens = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DkimEnabled")) {
                    result.dkim_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DkimTokens")) {
                    result.dkim_tokens = try deserializeVerificationTokenList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "DkimVerificationStatus")) {
                    result.dkim_verification_status = std.meta.stringToEnum(VerificationStatus, try reader.readElementText());
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

pub fn deserializeIdentityMailFromDomainAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IdentityMailFromDomainAttributes {
    var result: IdentityMailFromDomainAttributes = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BehaviorOnMXFailure")) {
                    result.behavior_on_mx_failure = std.meta.stringToEnum(BehaviorOnMXFailure, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MailFromDomain")) {
                    result.mail_from_domain = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MailFromDomainStatus")) {
                    result.mail_from_domain_status = std.meta.stringToEnum(CustomMailFromStatus, try reader.readElementText());
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

pub fn deserializeIdentityNotificationAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IdentityNotificationAttributes {
    var result: IdentityNotificationAttributes = undefined;
    result.headers_in_bounce_notifications_enabled = false;
    result.headers_in_complaint_notifications_enabled = false;
    result.headers_in_delivery_notifications_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BounceTopic")) {
                    result.bounce_topic = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ComplaintTopic")) {
                    result.complaint_topic = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeliveryTopic")) {
                    result.delivery_topic = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeIdentityVerificationAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IdentityVerificationAttributes {
    var result: IdentityVerificationAttributes = undefined;
    result.verification_token = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "VerificationStatus")) {
                    result.verification_status = std.meta.stringToEnum(VerificationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VerificationToken")) {
                    result.verification_token = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeKinesisFirehoseDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KinesisFirehoseDestination {
    var result: KinesisFirehoseDestination = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeliveryStreamARN")) {
                    result.delivery_stream_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMRoleARN")) {
                    result.iam_role_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLambdaAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LambdaAction {
    var result: LambdaAction = undefined;
    result.invocation_type = null;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FunctionArn")) {
                    result.function_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvocationType")) {
                    result.invocation_type = std.meta.stringToEnum(InvocationType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeReceiptAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReceiptAction {
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
                    result.add_header_action = try deserializeAddHeaderAction(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "BounceAction")) {
                    result.bounce_action = try deserializeBounceAction(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ConnectAction")) {
                    result.connect_action = try deserializeConnectAction(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LambdaAction")) {
                    result.lambda_action = try deserializeLambdaAction(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3Action")) {
                    result.s3_action = try deserializeS3Action(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SNSAction")) {
                    result.sns_action = try deserializeSNSAction(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StopAction")) {
                    result.stop_action = try deserializeStopAction(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "WorkmailAction")) {
                    result.workmail_action = try deserializeWorkmailAction(reader, alloc);
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

pub fn deserializeReceiptFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReceiptFilter {
    var result: ReceiptFilter = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IpFilter")) {
                    result.ip_filter = try deserializeReceiptIpFilter(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeReceiptIpFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReceiptIpFilter {
    var result: ReceiptIpFilter = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cidr")) {
                    result.cidr = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = std.meta.stringToEnum(ReceiptFilterPolicy, try reader.readElementText());
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

pub fn deserializeReceiptRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReceiptRule {
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
                    result.actions = try deserializeReceiptActionsList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Recipients")) {
                    result.recipients = try deserializeRecipientsList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ScanEnabled")) {
                    result.scan_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TlsPolicy")) {
                    result.tls_policy = std.meta.stringToEnum(TlsPolicy, try reader.readElementText());
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

pub fn deserializeReceiptRuleSetMetadata(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReceiptRuleSetMetadata {
    var result: ReceiptRuleSetMetadata = undefined;
    result.created_timestamp = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedTimestamp")) {
                    result.created_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeReputationOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReputationOptions {
    _ = alloc;
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

pub fn deserializeS3Action(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3Action {
    var result: S3Action = undefined;
    result.iam_role_arn = null;
    result.kms_key_arn = null;
    result.object_key_prefix = null;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BucketName")) {
                    result.bucket_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IamRoleArn")) {
                    result.iam_role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyArn")) {
                    result.kms_key_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectKeyPrefix")) {
                    result.object_key_prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSNSAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SNSAction {
    var result: SNSAction = undefined;
    result.encoding = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Encoding")) {
                    result.encoding = std.meta.stringToEnum(SNSActionEncoding, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSNSDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SNSDestination {
    var result: SNSDestination = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TopicARN")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSendDataPoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SendDataPoint {
    _ = alloc;
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

pub fn deserializeStopAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StopAction {
    var result: StopAction = undefined;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Scope")) {
                    result.scope = std.meta.stringToEnum(StopScope, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTemplate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Template {
    var result: Template = undefined;
    result.html_part = null;
    result.subject_part = null;
    result.text_part = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HtmlPart")) {
                    result.html_part = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubjectPart")) {
                    result.subject_part = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TextPart")) {
                    result.text_part = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTemplateMetadata(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TemplateMetadata {
    var result: TemplateMetadata = undefined;
    result.created_timestamp = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedTimestamp")) {
                    result.created_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTrackingOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrackingOptions {
    var result: TrackingOptions = undefined;
    result.custom_redirect_domain = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CustomRedirectDomain")) {
                    result.custom_redirect_domain = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeWorkmailAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !WorkmailAction {
    var result: WorkmailAction = undefined;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OrganizationArn")) {
                    result.organization_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn serializeAddressList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeBouncedRecipientInfoList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const BouncedRecipientInfo, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeBouncedRecipientInfo(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeBulkEmailDestinationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const BulkEmailDestination, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeBulkEmailDestination(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeCloudWatchDimensionConfigurations(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CloudWatchDimensionConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeCloudWatchDimensionConfiguration(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeConfigurationSetAttributeList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ConfigurationSetAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeEventTypes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EventType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeExtensionFieldList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ExtensionField, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeExtensionField(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeIdentityList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMessageTagList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MessageTag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeMessageTag(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializePolicyNameList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeReceiptActionsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ReceiptAction, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeReceiptAction(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeReceiptRuleNamesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRecipientsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAddHeaderAction(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AddHeaderAction) !void {
    try buf.appendSlice(alloc, "<HeaderName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.header_name);
    try buf.appendSlice(alloc, "</HeaderName>");
    try buf.appendSlice(alloc, "<HeaderValue>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.header_value);
    try buf.appendSlice(alloc, "</HeaderValue>");
}

pub fn serializeBody(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Body) !void {
    if (value.html) |v| {
        try buf.appendSlice(alloc, "<Html>");
        try serializeContent(alloc, buf, v);
        try buf.appendSlice(alloc, "</Html>");
    }
    if (value.text) |v| {
        try buf.appendSlice(alloc, "<Text>");
        try serializeContent(alloc, buf, v);
        try buf.appendSlice(alloc, "</Text>");
    }
}

pub fn serializeBounceAction(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: BounceAction) !void {
    try buf.appendSlice(alloc, "<Message>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.message);
    try buf.appendSlice(alloc, "</Message>");
    try buf.appendSlice(alloc, "<Sender>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.sender);
    try buf.appendSlice(alloc, "</Sender>");
    try buf.appendSlice(alloc, "<SmtpReplyCode>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.smtp_reply_code);
    try buf.appendSlice(alloc, "</SmtpReplyCode>");
    if (value.status_code) |v| {
        try buf.appendSlice(alloc, "<StatusCode>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</StatusCode>");
    }
    if (value.topic_arn) |v| {
        try buf.appendSlice(alloc, "<TopicArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TopicArn>");
    }
}

pub fn serializeBouncedRecipientInfo(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: BouncedRecipientInfo) !void {
    if (value.bounce_type) |v| {
        try buf.appendSlice(alloc, "<BounceType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</BounceType>");
    }
    try buf.appendSlice(alloc, "<Recipient>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.recipient);
    try buf.appendSlice(alloc, "</Recipient>");
    if (value.recipient_arn) |v| {
        try buf.appendSlice(alloc, "<RecipientArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</RecipientArn>");
    }
    if (value.recipient_dsn_fields) |v| {
        try buf.appendSlice(alloc, "<RecipientDsnFields>");
        try serializeRecipientDsnFields(alloc, buf, v);
        try buf.appendSlice(alloc, "</RecipientDsnFields>");
    }
}

pub fn serializeBulkEmailDestination(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: BulkEmailDestination) !void {
    try buf.appendSlice(alloc, "<Destination>");
    try serializeDestination(alloc, buf, value.destination);
    try buf.appendSlice(alloc, "</Destination>");
    if (value.replacement_tags) |v| {
        try buf.appendSlice(alloc, "<ReplacementTags>");
        try serializeMessageTagList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</ReplacementTags>");
    }
    if (value.replacement_template_data) |v| {
        try buf.appendSlice(alloc, "<ReplacementTemplateData>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ReplacementTemplateData>");
    }
}

pub fn serializeCloudWatchDestination(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudWatchDestination) !void {
    try buf.appendSlice(alloc, "<DimensionConfigurations>");
    try serializeCloudWatchDimensionConfigurations(alloc, buf, value.dimension_configurations, "member");
    try buf.appendSlice(alloc, "</DimensionConfigurations>");
}

pub fn serializeCloudWatchDimensionConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudWatchDimensionConfiguration) !void {
    try buf.appendSlice(alloc, "<DefaultDimensionValue>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.default_dimension_value);
    try buf.appendSlice(alloc, "</DefaultDimensionValue>");
    try buf.appendSlice(alloc, "<DimensionName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.dimension_name);
    try buf.appendSlice(alloc, "</DimensionName>");
    try buf.appendSlice(alloc, "<DimensionValueSource>");
    try buf.appendSlice(alloc, @tagName(value.dimension_value_source));
    try buf.appendSlice(alloc, "</DimensionValueSource>");
}

pub fn serializeConfigurationSet(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConfigurationSet) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
}

pub fn serializeConnectAction(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectAction) !void {
    try buf.appendSlice(alloc, "<IAMRoleARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.iam_role_arn);
    try buf.appendSlice(alloc, "</IAMRoleARN>");
    try buf.appendSlice(alloc, "<InstanceARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.instance_arn);
    try buf.appendSlice(alloc, "</InstanceARN>");
}

pub fn serializeContent(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Content) !void {
    if (value.charset) |v| {
        try buf.appendSlice(alloc, "<Charset>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Charset>");
    }
    try buf.appendSlice(alloc, "<Data>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.data);
    try buf.appendSlice(alloc, "</Data>");
}

pub fn serializeDeliveryOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DeliveryOptions) !void {
    if (value.tls_policy) |v| {
        try buf.appendSlice(alloc, "<TlsPolicy>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</TlsPolicy>");
    }
}

pub fn serializeDestination(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Destination) !void {
    if (value.bcc_addresses) |v| {
        try buf.appendSlice(alloc, "<BccAddresses>");
        try serializeAddressList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</BccAddresses>");
    }
    if (value.cc_addresses) |v| {
        try buf.appendSlice(alloc, "<CcAddresses>");
        try serializeAddressList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</CcAddresses>");
    }
    if (value.to_addresses) |v| {
        try buf.appendSlice(alloc, "<ToAddresses>");
        try serializeAddressList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</ToAddresses>");
    }
}

pub fn serializeEventDestination(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: EventDestination) !void {
    if (value.cloud_watch_destination) |v| {
        try buf.appendSlice(alloc, "<CloudWatchDestination>");
        try serializeCloudWatchDestination(alloc, buf, v);
        try buf.appendSlice(alloc, "</CloudWatchDestination>");
    }
    if (value.enabled) |v| {
        try buf.appendSlice(alloc, "<Enabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Enabled>");
    }
    if (value.kinesis_firehose_destination) |v| {
        try buf.appendSlice(alloc, "<KinesisFirehoseDestination>");
        try serializeKinesisFirehoseDestination(alloc, buf, v);
        try buf.appendSlice(alloc, "</KinesisFirehoseDestination>");
    }
    try buf.appendSlice(alloc, "<MatchingEventTypes>");
    try serializeEventTypes(alloc, buf, value.matching_event_types, "member");
    try buf.appendSlice(alloc, "</MatchingEventTypes>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    if (value.sns_destination) |v| {
        try buf.appendSlice(alloc, "<SNSDestination>");
        try serializeSNSDestination(alloc, buf, v);
        try buf.appendSlice(alloc, "</SNSDestination>");
    }
}

pub fn serializeExtensionField(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ExtensionField) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeKinesisFirehoseDestination(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: KinesisFirehoseDestination) !void {
    try buf.appendSlice(alloc, "<DeliveryStreamARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.delivery_stream_arn);
    try buf.appendSlice(alloc, "</DeliveryStreamARN>");
    try buf.appendSlice(alloc, "<IAMRoleARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.iam_role_arn);
    try buf.appendSlice(alloc, "</IAMRoleARN>");
}

pub fn serializeLambdaAction(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LambdaAction) !void {
    try buf.appendSlice(alloc, "<FunctionArn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.function_arn);
    try buf.appendSlice(alloc, "</FunctionArn>");
    if (value.invocation_type) |v| {
        try buf.appendSlice(alloc, "<InvocationType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</InvocationType>");
    }
    if (value.topic_arn) |v| {
        try buf.appendSlice(alloc, "<TopicArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TopicArn>");
    }
}

pub fn serializeMessage(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Message) !void {
    try buf.appendSlice(alloc, "<Body>");
    try serializeBody(alloc, buf, value.body);
    try buf.appendSlice(alloc, "</Body>");
    try buf.appendSlice(alloc, "<Subject>");
    try serializeContent(alloc, buf, value.subject);
    try buf.appendSlice(alloc, "</Subject>");
}

pub fn serializeMessageDsn(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MessageDsn) !void {
    if (value.arrival_date) |v| {
        try buf.appendSlice(alloc, "<ArrivalDate>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</ArrivalDate>");
    }
    if (value.extension_fields) |v| {
        try buf.appendSlice(alloc, "<ExtensionFields>");
        try serializeExtensionFieldList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</ExtensionFields>");
    }
    try buf.appendSlice(alloc, "<ReportingMta>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.reporting_mta);
    try buf.appendSlice(alloc, "</ReportingMta>");
}

pub fn serializeMessageTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MessageTag) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeRawMessage(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RawMessage) !void {
    _ = alloc;
    _ = buf;
    _ = value;
}

pub fn serializeReceiptAction(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReceiptAction) !void {
    if (value.add_header_action) |v| {
        try buf.appendSlice(alloc, "<AddHeaderAction>");
        try serializeAddHeaderAction(alloc, buf, v);
        try buf.appendSlice(alloc, "</AddHeaderAction>");
    }
    if (value.bounce_action) |v| {
        try buf.appendSlice(alloc, "<BounceAction>");
        try serializeBounceAction(alloc, buf, v);
        try buf.appendSlice(alloc, "</BounceAction>");
    }
    if (value.connect_action) |v| {
        try buf.appendSlice(alloc, "<ConnectAction>");
        try serializeConnectAction(alloc, buf, v);
        try buf.appendSlice(alloc, "</ConnectAction>");
    }
    if (value.lambda_action) |v| {
        try buf.appendSlice(alloc, "<LambdaAction>");
        try serializeLambdaAction(alloc, buf, v);
        try buf.appendSlice(alloc, "</LambdaAction>");
    }
    if (value.s3_action) |v| {
        try buf.appendSlice(alloc, "<S3Action>");
        try serializeS3Action(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3Action>");
    }
    if (value.sns_action) |v| {
        try buf.appendSlice(alloc, "<SNSAction>");
        try serializeSNSAction(alloc, buf, v);
        try buf.appendSlice(alloc, "</SNSAction>");
    }
    if (value.stop_action) |v| {
        try buf.appendSlice(alloc, "<StopAction>");
        try serializeStopAction(alloc, buf, v);
        try buf.appendSlice(alloc, "</StopAction>");
    }
    if (value.workmail_action) |v| {
        try buf.appendSlice(alloc, "<WorkmailAction>");
        try serializeWorkmailAction(alloc, buf, v);
        try buf.appendSlice(alloc, "</WorkmailAction>");
    }
}

pub fn serializeReceiptFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReceiptFilter) !void {
    try buf.appendSlice(alloc, "<IpFilter>");
    try serializeReceiptIpFilter(alloc, buf, value.ip_filter);
    try buf.appendSlice(alloc, "</IpFilter>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
}

pub fn serializeReceiptIpFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReceiptIpFilter) !void {
    try buf.appendSlice(alloc, "<Cidr>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.cidr);
    try buf.appendSlice(alloc, "</Cidr>");
    try buf.appendSlice(alloc, "<Policy>");
    try buf.appendSlice(alloc, @tagName(value.policy));
    try buf.appendSlice(alloc, "</Policy>");
}

pub fn serializeReceiptRule(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReceiptRule) !void {
    if (value.actions) |v| {
        try buf.appendSlice(alloc, "<Actions>");
        try serializeReceiptActionsList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Actions>");
    }
    if (value.enabled) |v| {
        try buf.appendSlice(alloc, "<Enabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Enabled>");
    }
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    if (value.recipients) |v| {
        try buf.appendSlice(alloc, "<Recipients>");
        try serializeRecipientsList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Recipients>");
    }
    if (value.scan_enabled) |v| {
        try buf.appendSlice(alloc, "<ScanEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ScanEnabled>");
    }
    if (value.tls_policy) |v| {
        try buf.appendSlice(alloc, "<TlsPolicy>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</TlsPolicy>");
    }
}

pub fn serializeRecipientDsnFields(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RecipientDsnFields) !void {
    try buf.appendSlice(alloc, "<Action>");
    try buf.appendSlice(alloc, @tagName(value.action));
    try buf.appendSlice(alloc, "</Action>");
    if (value.diagnostic_code) |v| {
        try buf.appendSlice(alloc, "<DiagnosticCode>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DiagnosticCode>");
    }
    if (value.extension_fields) |v| {
        try buf.appendSlice(alloc, "<ExtensionFields>");
        try serializeExtensionFieldList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</ExtensionFields>");
    }
    if (value.final_recipient) |v| {
        try buf.appendSlice(alloc, "<FinalRecipient>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</FinalRecipient>");
    }
    if (value.last_attempt_date) |v| {
        try buf.appendSlice(alloc, "<LastAttemptDate>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</LastAttemptDate>");
    }
    if (value.remote_mta) |v| {
        try buf.appendSlice(alloc, "<RemoteMta>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</RemoteMta>");
    }
    try buf.appendSlice(alloc, "<Status>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.status);
    try buf.appendSlice(alloc, "</Status>");
}

pub fn serializeS3Action(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Action) !void {
    try buf.appendSlice(alloc, "<BucketName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.bucket_name);
    try buf.appendSlice(alloc, "</BucketName>");
    if (value.iam_role_arn) |v| {
        try buf.appendSlice(alloc, "<IamRoleArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</IamRoleArn>");
    }
    if (value.kms_key_arn) |v| {
        try buf.appendSlice(alloc, "<KmsKeyArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</KmsKeyArn>");
    }
    if (value.object_key_prefix) |v| {
        try buf.appendSlice(alloc, "<ObjectKeyPrefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ObjectKeyPrefix>");
    }
    if (value.topic_arn) |v| {
        try buf.appendSlice(alloc, "<TopicArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TopicArn>");
    }
}

pub fn serializeSNSAction(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SNSAction) !void {
    if (value.encoding) |v| {
        try buf.appendSlice(alloc, "<Encoding>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Encoding>");
    }
    try buf.appendSlice(alloc, "<TopicArn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.topic_arn);
    try buf.appendSlice(alloc, "</TopicArn>");
}

pub fn serializeSNSDestination(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SNSDestination) !void {
    try buf.appendSlice(alloc, "<TopicARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.topic_arn);
    try buf.appendSlice(alloc, "</TopicARN>");
}

pub fn serializeStopAction(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StopAction) !void {
    try buf.appendSlice(alloc, "<Scope>");
    try buf.appendSlice(alloc, @tagName(value.scope));
    try buf.appendSlice(alloc, "</Scope>");
    if (value.topic_arn) |v| {
        try buf.appendSlice(alloc, "<TopicArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TopicArn>");
    }
}

pub fn serializeTemplate(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Template) !void {
    if (value.html_part) |v| {
        try buf.appendSlice(alloc, "<HtmlPart>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</HtmlPart>");
    }
    if (value.subject_part) |v| {
        try buf.appendSlice(alloc, "<SubjectPart>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SubjectPart>");
    }
    try buf.appendSlice(alloc, "<TemplateName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.template_name);
    try buf.appendSlice(alloc, "</TemplateName>");
    if (value.text_part) |v| {
        try buf.appendSlice(alloc, "<TextPart>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TextPart>");
    }
}

pub fn serializeTrackingOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrackingOptions) !void {
    if (value.custom_redirect_domain) |v| {
        try buf.appendSlice(alloc, "<CustomRedirectDomain>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</CustomRedirectDomain>");
    }
}

pub fn serializeWorkmailAction(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: WorkmailAction) !void {
    try buf.appendSlice(alloc, "<OrganizationArn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.organization_arn);
    try buf.appendSlice(alloc, "</OrganizationArn>");
    if (value.topic_arn) |v| {
        try buf.appendSlice(alloc, "<TopicArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TopicArn>");
    }
}

