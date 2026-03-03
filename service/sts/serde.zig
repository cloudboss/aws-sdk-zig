const aws = @import("aws");
const std = @import("std");

const AssumedRoleUser = @import("assumed_role_user.zig").AssumedRoleUser;
const Credentials = @import("credentials.zig").Credentials;
const FederatedUser = @import("federated_user.zig").FederatedUser;
const PolicyDescriptorType = @import("policy_descriptor_type.zig").PolicyDescriptorType;
const ProvidedContext = @import("provided_context.zig").ProvidedContext;
const Tag = @import("tag.zig").Tag;

pub fn deserializeAssumedRoleUser(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AssumedRoleUser {
    var result: AssumedRoleUser = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AssumedRoleId")) {
                    result.assumed_role_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCredentials(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Credentials {
    var result: Credentials = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessKeyId")) {
                    result.access_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecretAccessKey")) {
                    result.secret_access_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionToken")) {
                    result.session_token = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFederatedUser(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FederatedUser {
    var result: FederatedUser = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FederatedUserId")) {
                    result.federated_user_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn serializeProvidedContextsListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ProvidedContext, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeProvidedContext(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializepolicyDescriptorListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PolicyDescriptorType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializePolicyDescriptorType(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializetagKeyListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializetagListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
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

pub fn serializewebIdentityTokenAudienceListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePolicyDescriptorType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PolicyDescriptorType) !void {
    if (value.arn) |v| {
        try buf.appendSlice(allocator, "<arn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</arn>");
    }
}

pub fn serializeProvidedContext(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ProvidedContext) !void {
    if (value.context_assertion) |v| {
        try buf.appendSlice(allocator, "<ContextAssertion>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContextAssertion>");
    }
    if (value.provider_arn) |v| {
        try buf.appendSlice(allocator, "<ProviderArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ProviderArn>");
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

