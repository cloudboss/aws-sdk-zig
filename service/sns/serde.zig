const aws = @import("aws");
const std = @import("std");

const BatchResultErrorEntry = @import("batch_result_error_entry.zig").BatchResultErrorEntry;
const Endpoint = @import("endpoint.zig").Endpoint;
const MessageAttributeValue = @import("message_attribute_value.zig").MessageAttributeValue;
const NumberCapability = @import("number_capability.zig").NumberCapability;
const PhoneNumberInformation = @import("phone_number_information.zig").PhoneNumberInformation;
const PlatformApplication = @import("platform_application.zig").PlatformApplication;
const PublishBatchRequestEntry = @import("publish_batch_request_entry.zig").PublishBatchRequestEntry;
const PublishBatchResultEntry = @import("publish_batch_result_entry.zig").PublishBatchResultEntry;
const RouteType = @import("route_type.zig").RouteType;
const SMSSandboxPhoneNumber = @import("sms_sandbox_phone_number.zig").SMSSandboxPhoneNumber;
const SMSSandboxPhoneNumberVerificationStatus = @import("sms_sandbox_phone_number_verification_status.zig").SMSSandboxPhoneNumberVerificationStatus;
const Subscription = @import("subscription.zig").Subscription;
const Tag = @import("tag.zig").Tag;
const Topic = @import("topic.zig").Topic;

pub fn deserializeBatchResultErrorEntryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const BatchResultErrorEntry {
    var list: std.ArrayList(BatchResultErrorEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeBatchResultErrorEntry(allocator, reader));
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

pub fn deserializeListOfEndpoints(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Endpoint {
    var list: std.ArrayList(Endpoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEndpoint(allocator, reader));
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

pub fn deserializeListOfPlatformApplications(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PlatformApplication {
    var list: std.ArrayList(PlatformApplication) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePlatformApplication(allocator, reader));
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

pub fn deserializeNumberCapabilityList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NumberCapability {
    var list: std.ArrayList(NumberCapability) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(NumberCapability, try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializePhoneNumberInformationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PhoneNumberInformation {
    var list: std.ArrayList(PhoneNumberInformation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePhoneNumberInformation(allocator, reader));
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

pub fn deserializePhoneNumberList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializePublishBatchResultEntryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PublishBatchResultEntry {
    var list: std.ArrayList(PublishBatchResultEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePublishBatchResultEntry(allocator, reader));
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

pub fn deserializeSMSSandboxPhoneNumberList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SMSSandboxPhoneNumber {
    var list: std.ArrayList(SMSSandboxPhoneNumber) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSMSSandboxPhoneNumber(allocator, reader));
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

pub fn deserializeSubscriptionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Subscription {
    var list: std.ArrayList(Subscription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSubscription(allocator, reader));
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

pub fn deserializeTagList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTag(allocator, reader));
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

pub fn deserializeTopicsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Topic {
    var list: std.ArrayList(Topic) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTopic(allocator, reader));
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

pub fn deserializeMapStringToString(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeSubscriptionAttributesMap(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeTopicAttributesMap(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeBatchResultErrorEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BatchResultErrorEntry {
    var result: BatchResultErrorEntry = undefined;
    result.message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SenderFault")) {
                    result.sender_fault = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeEndpoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Endpoint {
    var result: Endpoint = undefined;
    result.attributes = null;
    result.endpoint_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Attributes")) {
                    result.attributes = try deserializeMapStringToString(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "EndpointArn")) {
                    result.endpoint_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePhoneNumberInformation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PhoneNumberInformation {
    var result: PhoneNumberInformation = undefined;
    result.created_at = null;
    result.iso_2_country_code = null;
    result.number_capabilities = null;
    result.phone_number = null;
    result.route_type = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Iso2CountryCode")) {
                    result.iso_2_country_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberCapabilities")) {
                    result.number_capabilities = try deserializeNumberCapabilityList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PhoneNumber")) {
                    result.phone_number = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RouteType")) {
                    result.route_type = std.meta.stringToEnum(RouteType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePlatformApplication(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PlatformApplication {
    var result: PlatformApplication = undefined;
    result.attributes = null;
    result.platform_application_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Attributes")) {
                    result.attributes = try deserializeMapStringToString(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "PlatformApplicationArn")) {
                    result.platform_application_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePublishBatchResultEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PublishBatchResultEntry {
    var result: PublishBatchResultEntry = undefined;
    result.id = null;
    result.message_id = null;
    result.sequence_number = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MessageId")) {
                    result.message_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SequenceNumber")) {
                    result.sequence_number = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeSMSSandboxPhoneNumber(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SMSSandboxPhoneNumber {
    var result: SMSSandboxPhoneNumber = undefined;
    result.phone_number = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PhoneNumber")) {
                    result.phone_number = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(SMSSandboxPhoneNumberVerificationStatus, try reader.readElementText());
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

pub fn deserializeSubscription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Subscription {
    var result: Subscription = undefined;
    result.endpoint = null;
    result.owner = null;
    result.protocol = null;
    result.subscription_arn = null;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubscriptionArn")) {
                    result.subscription_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTag(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Tag {
    var result: Tag = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTopic(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Topic {
    var result: Topic = undefined;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TopicArn")) {
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

pub fn serializeActionsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeDelegatesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeListString(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePublishBatchRequestEntryList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PublishBatchRequestEntry, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializePublishBatchRequestEntry(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTagKeyList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTagList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTag(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMapStringToString(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, "<key>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.key);
        try buf.appendSlice(allocator, "</key>");
        try buf.appendSlice(allocator, "<value>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.value);
        try buf.appendSlice(allocator, "</value>");
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMessageAttributeMap(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.MapEntry(MessageAttributeValue), comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, "<Name>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.key);
        try buf.appendSlice(allocator, "</Name>");
        try buf.appendSlice(allocator, "<Value>");
        try serializeMessageAttributeValue(allocator, buf, entry.value);
        try buf.appendSlice(allocator, "</Value>");
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSubscriptionAttributesMap(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, "<key>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.key);
        try buf.appendSlice(allocator, "</key>");
        try buf.appendSlice(allocator, "<value>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.value);
        try buf.appendSlice(allocator, "</value>");
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTopicAttributesMap(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, "<key>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.key);
        try buf.appendSlice(allocator, "</key>");
        try buf.appendSlice(allocator, "<value>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.value);
        try buf.appendSlice(allocator, "</value>");
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMessageAttributeValue(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MessageAttributeValue) !void {
    try buf.appendSlice(allocator, "<DataType>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.data_type);
    try buf.appendSlice(allocator, "</DataType>");
    if (value.string_value) |v| {
        try buf.appendSlice(allocator, "<StringValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</StringValue>");
    }
}

pub fn serializePublishBatchRequestEntry(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PublishBatchRequestEntry) !void {
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    try buf.appendSlice(allocator, "<Message>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.message);
    try buf.appendSlice(allocator, "</Message>");
    if (value.message_attributes) |v| {
        try buf.appendSlice(allocator, "<MessageAttributes>");
        try serializeMessageAttributeMap(allocator, buf, v, "entry");
        try buf.appendSlice(allocator, "</MessageAttributes>");
    }
    if (value.message_deduplication_id) |v| {
        try buf.appendSlice(allocator, "<MessageDeduplicationId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</MessageDeduplicationId>");
    }
    if (value.message_group_id) |v| {
        try buf.appendSlice(allocator, "<MessageGroupId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</MessageGroupId>");
    }
    if (value.message_structure) |v| {
        try buf.appendSlice(allocator, "<MessageStructure>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</MessageStructure>");
    }
    if (value.subject) |v| {
        try buf.appendSlice(allocator, "<Subject>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Subject>");
    }
}

pub fn serializeTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

