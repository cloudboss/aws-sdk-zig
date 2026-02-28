const aws = @import("aws");
const std = @import("std");

const AssumedRoleUser = @import("assumed_role_user.zig").AssumedRoleUser;
const Credentials = @import("credentials.zig").Credentials;
const FederatedUser = @import("federated_user.zig").FederatedUser;
const PolicyDescriptorType = @import("policy_descriptor_type.zig").PolicyDescriptorType;
const ProvidedContext = @import("provided_context.zig").ProvidedContext;
const Tag = @import("tag.zig").Tag;

pub fn deserializeAssumedRoleUser(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AssumedRoleUser {
    var result: AssumedRoleUser = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AssumedRoleId")) {
                    result.assumed_role_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeCredentials(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Credentials {
    var result: Credentials = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessKeyId")) {
                    result.access_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecretAccessKey")) {
                    result.secret_access_key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionToken")) {
                    result.session_token = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeFederatedUser(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FederatedUser {
    var result: FederatedUser = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FederatedUserId")) {
                    result.federated_user_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn serializeProvidedContextsListType(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ProvidedContext, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeProvidedContext(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializepolicyDescriptorListType(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PolicyDescriptorType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializePolicyDescriptorType(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializetagKeyListType(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializetagListType(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTag(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializewebIdentityTokenAudienceListType(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePolicyDescriptorType(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PolicyDescriptorType) !void {
    if (value.arn) |v| {
        try buf.appendSlice(alloc, "<arn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</arn>");
    }
}

pub fn serializeProvidedContext(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ProvidedContext) !void {
    if (value.context_assertion) |v| {
        try buf.appendSlice(alloc, "<ContextAssertion>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContextAssertion>");
    }
    if (value.provider_arn) |v| {
        try buf.appendSlice(alloc, "<ProviderArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ProviderArn>");
    }
}

pub fn serializeTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(alloc, "<Key>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key);
    try buf.appendSlice(alloc, "</Key>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

