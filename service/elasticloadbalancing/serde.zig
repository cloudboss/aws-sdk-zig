const aws = @import("aws");
const std = @import("std");

const AccessLog = @import("access_log.zig").AccessLog;
const AdditionalAttribute = @import("additional_attribute.zig").AdditionalAttribute;
const AppCookieStickinessPolicy = @import("app_cookie_stickiness_policy.zig").AppCookieStickinessPolicy;
const BackendServerDescription = @import("backend_server_description.zig").BackendServerDescription;
const ConnectionDraining = @import("connection_draining.zig").ConnectionDraining;
const ConnectionSettings = @import("connection_settings.zig").ConnectionSettings;
const CrossZoneLoadBalancing = @import("cross_zone_load_balancing.zig").CrossZoneLoadBalancing;
const HealthCheck = @import("health_check.zig").HealthCheck;
const Instance = @import("instance.zig").Instance;
const InstanceState = @import("instance_state.zig").InstanceState;
const LBCookieStickinessPolicy = @import("lb_cookie_stickiness_policy.zig").LBCookieStickinessPolicy;
const Limit = @import("limit.zig").Limit;
const Listener = @import("listener.zig").Listener;
const ListenerDescription = @import("listener_description.zig").ListenerDescription;
const LoadBalancerAttributes = @import("load_balancer_attributes.zig").LoadBalancerAttributes;
const LoadBalancerDescription = @import("load_balancer_description.zig").LoadBalancerDescription;
const Policies = @import("policies.zig").Policies;
const PolicyAttribute = @import("policy_attribute.zig").PolicyAttribute;
const PolicyAttributeDescription = @import("policy_attribute_description.zig").PolicyAttributeDescription;
const PolicyAttributeTypeDescription = @import("policy_attribute_type_description.zig").PolicyAttributeTypeDescription;
const PolicyDescription = @import("policy_description.zig").PolicyDescription;
const PolicyTypeDescription = @import("policy_type_description.zig").PolicyTypeDescription;
const SourceSecurityGroup = @import("source_security_group.zig").SourceSecurityGroup;
const Tag = @import("tag.zig").Tag;
const TagDescription = @import("tag_description.zig").TagDescription;
const TagKeyOnly = @import("tag_key_only.zig").TagKeyOnly;

pub fn deserializeAdditionalAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AdditionalAttribute {
    var list: std.ArrayList(AdditionalAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAdditionalAttribute(reader, alloc));
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

pub fn deserializeAppCookieStickinessPolicies(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AppCookieStickinessPolicy {
    var list: std.ArrayList(AppCookieStickinessPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAppCookieStickinessPolicy(reader, alloc));
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

pub fn deserializeAvailabilityZones(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeBackendServerDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const BackendServerDescription {
    var list: std.ArrayList(BackendServerDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeBackendServerDescription(reader, alloc));
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

pub fn deserializeInstanceStates(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InstanceState {
    var list: std.ArrayList(InstanceState) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInstanceState(reader, alloc));
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

pub fn deserializeInstances(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Instance {
    var list: std.ArrayList(Instance) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInstance(reader, alloc));
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

pub fn deserializeLBCookieStickinessPolicies(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LBCookieStickinessPolicy {
    var list: std.ArrayList(LBCookieStickinessPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLBCookieStickinessPolicy(reader, alloc));
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

pub fn deserializeLimits(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Limit {
    var list: std.ArrayList(Limit) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLimit(reader, alloc));
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

pub fn deserializeListenerDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ListenerDescription {
    var list: std.ArrayList(ListenerDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeListenerDescription(reader, alloc));
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

pub fn deserializeLoadBalancerDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LoadBalancerDescription {
    var list: std.ArrayList(LoadBalancerDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLoadBalancerDescription(reader, alloc));
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

pub fn deserializePolicyAttributeDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyAttributeDescription {
    var list: std.ArrayList(PolicyAttributeDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyAttributeDescription(reader, alloc));
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

pub fn deserializePolicyAttributeTypeDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyAttributeTypeDescription {
    var list: std.ArrayList(PolicyAttributeTypeDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyAttributeTypeDescription(reader, alloc));
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

pub fn deserializePolicyDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyDescription {
    var list: std.ArrayList(PolicyDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyDescription(reader, alloc));
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

pub fn deserializePolicyNames(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializePolicyTypeDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyTypeDescription {
    var list: std.ArrayList(PolicyTypeDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyTypeDescription(reader, alloc));
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

pub fn deserializeSecurityGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSubnets(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTagDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TagDescription {
    var list: std.ArrayList(TagDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTagDescription(reader, alloc));
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

pub fn deserializeTagList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTag(reader, alloc));
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

pub fn deserializeAccessLog(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccessLog {
    var result: AccessLog = undefined;
    result.emit_interval = null;
    result.s3_bucket_name = null;
    result.s3_bucket_prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EmitInterval")) {
                    result.emit_interval = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "S3BucketName")) {
                    result.s3_bucket_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3BucketPrefix")) {
                    result.s3_bucket_prefix = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAdditionalAttribute(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AdditionalAttribute {
    var result: AdditionalAttribute = undefined;
    result.key = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAppCookieStickinessPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AppCookieStickinessPolicy {
    var result: AppCookieStickinessPolicy = undefined;
    result.cookie_name = null;
    result.policy_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CookieName")) {
                    result.cookie_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeBackendServerDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BackendServerDescription {
    var result: BackendServerDescription = undefined;
    result.instance_port = null;
    result.policy_names = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstancePort")) {
                    result.instance_port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PolicyNames")) {
                    result.policy_names = try deserializePolicyNames(reader, alloc, "member");
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

pub fn deserializeConnectionDraining(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConnectionDraining {
    _ = alloc;
    var result: ConnectionDraining = undefined;
    result.timeout = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Timeout")) {
                    result.timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeConnectionSettings(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConnectionSettings {
    _ = alloc;
    var result: ConnectionSettings = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IdleTimeout")) {
                    result.idle_timeout = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
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

pub fn deserializeCrossZoneLoadBalancing(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CrossZoneLoadBalancing {
    _ = alloc;
    var result: CrossZoneLoadBalancing = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeHealthCheck(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HealthCheck {
    var result: HealthCheck = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HealthyThreshold")) {
                    result.healthy_threshold = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Interval")) {
                    result.interval = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Target")) {
                    result.target = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timeout")) {
                    result.timeout = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "UnhealthyThreshold")) {
                    result.unhealthy_threshold = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
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

pub fn deserializeInstance(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Instance {
    var result: Instance = undefined;
    result.instance_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstanceId")) {
                    result.instance_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeInstanceState(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceState {
    var result: InstanceState = undefined;
    result.description = null;
    result.instance_id = null;
    result.reason_code = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceId")) {
                    result.instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReasonCode")) {
                    result.reason_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLBCookieStickinessPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LBCookieStickinessPolicy {
    var result: LBCookieStickinessPolicy = undefined;
    result.cookie_expiration_period = null;
    result.policy_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CookieExpirationPeriod")) {
                    result.cookie_expiration_period = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLimit(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Limit {
    var result: Limit = undefined;
    result.max = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeListener(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Listener {
    var result: Listener = undefined;
    result.instance_protocol = null;
    result.ssl_certificate_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstancePort")) {
                    result.instance_port = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "InstanceProtocol")) {
                    result.instance_protocol = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LoadBalancerPort")) {
                    result.load_balancer_port = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SSLCertificateId")) {
                    result.ssl_certificate_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeListenerDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ListenerDescription {
    var result: ListenerDescription = undefined;
    result.listener = null;
    result.policy_names = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Listener")) {
                    result.listener = try deserializeListener(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PolicyNames")) {
                    result.policy_names = try deserializePolicyNames(reader, alloc, "member");
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

pub fn deserializeLoadBalancerAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadBalancerAttributes {
    var result: LoadBalancerAttributes = undefined;
    result.access_log = null;
    result.additional_attributes = null;
    result.connection_draining = null;
    result.connection_settings = null;
    result.cross_zone_load_balancing = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessLog")) {
                    result.access_log = try deserializeAccessLog(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AdditionalAttributes")) {
                    result.additional_attributes = try deserializeAdditionalAttributes(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ConnectionDraining")) {
                    result.connection_draining = try deserializeConnectionDraining(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ConnectionSettings")) {
                    result.connection_settings = try deserializeConnectionSettings(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CrossZoneLoadBalancing")) {
                    result.cross_zone_load_balancing = try deserializeCrossZoneLoadBalancing(reader, alloc);
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

pub fn deserializeLoadBalancerDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadBalancerDescription {
    var result: LoadBalancerDescription = undefined;
    result.availability_zones = null;
    result.backend_server_descriptions = null;
    result.canonical_hosted_zone_name = null;
    result.canonical_hosted_zone_name_id = null;
    result.created_time = null;
    result.dns_name = null;
    result.health_check = null;
    result.instances = null;
    result.listener_descriptions = null;
    result.load_balancer_name = null;
    result.policies = null;
    result.scheme = null;
    result.security_groups = null;
    result.source_security_group = null;
    result.subnets = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "BackendServerDescriptions")) {
                    result.backend_server_descriptions = try deserializeBackendServerDescriptions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "CanonicalHostedZoneName")) {
                    result.canonical_hosted_zone_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CanonicalHostedZoneNameID")) {
                    result.canonical_hosted_zone_name_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DNSName")) {
                    result.dns_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthCheck")) {
                    result.health_check = try deserializeHealthCheck(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Instances")) {
                    result.instances = try deserializeInstances(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ListenerDescriptions")) {
                    result.listener_descriptions = try deserializeListenerDescriptions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Policies")) {
                    result.policies = try deserializePolicies(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Scheme")) {
                    result.scheme = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecurityGroups")) {
                    result.security_groups = try deserializeSecurityGroups(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SourceSecurityGroup")) {
                    result.source_security_group = try deserializeSourceSecurityGroup(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Subnets")) {
                    result.subnets = try deserializeSubnets(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "VPCId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicies(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Policies {
    var result: Policies = undefined;
    result.app_cookie_stickiness_policies = null;
    result.lb_cookie_stickiness_policies = null;
    result.other_policies = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AppCookieStickinessPolicies")) {
                    result.app_cookie_stickiness_policies = try deserializeAppCookieStickinessPolicies(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LBCookieStickinessPolicies")) {
                    result.lb_cookie_stickiness_policies = try deserializeLBCookieStickinessPolicies(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "OtherPolicies")) {
                    result.other_policies = try deserializePolicyNames(reader, alloc, "member");
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

pub fn deserializePolicyAttributeDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyAttributeDescription {
    var result: PolicyAttributeDescription = undefined;
    result.attribute_name = null;
    result.attribute_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AttributeName")) {
                    result.attribute_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeValue")) {
                    result.attribute_value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicyAttributeTypeDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyAttributeTypeDescription {
    var result: PolicyAttributeTypeDescription = undefined;
    result.attribute_name = null;
    result.attribute_type = null;
    result.cardinality = null;
    result.default_value = null;
    result.description = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AttributeName")) {
                    result.attribute_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeType")) {
                    result.attribute_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Cardinality")) {
                    result.cardinality = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicyDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyDescription {
    var result: PolicyDescription = undefined;
    result.policy_attribute_descriptions = null;
    result.policy_name = null;
    result.policy_type_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PolicyAttributeDescriptions")) {
                    result.policy_attribute_descriptions = try deserializePolicyAttributeDescriptions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyTypeName")) {
                    result.policy_type_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicyTypeDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyTypeDescription {
    var result: PolicyTypeDescription = undefined;
    result.description = null;
    result.policy_attribute_type_descriptions = null;
    result.policy_type_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyAttributeTypeDescriptions")) {
                    result.policy_attribute_type_descriptions = try deserializePolicyAttributeTypeDescriptions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "PolicyTypeName")) {
                    result.policy_type_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSourceSecurityGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SourceSecurityGroup {
    var result: SourceSecurityGroup = undefined;
    result.group_name = null;
    result.owner_alias = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GroupName")) {
                    result.group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OwnerAlias")) {
                    result.owner_alias = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTag(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Tag {
    var result: Tag = undefined;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTagDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TagDescription {
    var result: TagDescription = undefined;
    result.load_balancer_name = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(reader, alloc, "member");
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

pub fn serializeAdditionalAttributes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AdditionalAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeAdditionalAttribute(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAvailabilityZones(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeInstances(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Instance, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeInstance(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeListeners(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Listener, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeListener(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeLoadBalancerNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLoadBalancerNamesMax20(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePolicyAttributes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PolicyAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializePolicyAttribute(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializePolicyNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePolicyTypeNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePorts(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const i32, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{item}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeSecurityGroups(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeSubnets(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTagKeyList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TagKeyOnly, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTagKeyOnly(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTagList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
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

pub fn serializeAccessLog(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccessLog) !void {
    if (value.emit_interval) |v| {
        try buf.appendSlice(alloc, "<EmitInterval>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</EmitInterval>");
    }
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.s3_bucket_name) |v| {
        try buf.appendSlice(alloc, "<S3BucketName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3BucketName>");
    }
    if (value.s3_bucket_prefix) |v| {
        try buf.appendSlice(alloc, "<S3BucketPrefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3BucketPrefix>");
    }
}

pub fn serializeAdditionalAttribute(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AdditionalAttribute) !void {
    if (value.key) |v| {
        try buf.appendSlice(alloc, "<Key>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Key>");
    }
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Value>");
    }
}

pub fn serializeConnectionDraining(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectionDraining) !void {
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.timeout) |v| {
        try buf.appendSlice(alloc, "<Timeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Timeout>");
    }
}

pub fn serializeConnectionSettings(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectionSettings) !void {
    try buf.appendSlice(alloc, "<IdleTimeout>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.idle_timeout}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</IdleTimeout>");
}

pub fn serializeCrossZoneLoadBalancing(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CrossZoneLoadBalancing) !void {
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
}

pub fn serializeHealthCheck(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: HealthCheck) !void {
    try buf.appendSlice(alloc, "<HealthyThreshold>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.healthy_threshold}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</HealthyThreshold>");
    try buf.appendSlice(alloc, "<Interval>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.interval}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Interval>");
    try buf.appendSlice(alloc, "<Target>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.target);
    try buf.appendSlice(alloc, "</Target>");
    try buf.appendSlice(alloc, "<Timeout>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.timeout}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Timeout>");
    try buf.appendSlice(alloc, "<UnhealthyThreshold>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.unhealthy_threshold}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</UnhealthyThreshold>");
}

pub fn serializeInstance(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Instance) !void {
    if (value.instance_id) |v| {
        try buf.appendSlice(alloc, "<InstanceId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</InstanceId>");
    }
}

pub fn serializeListener(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Listener) !void {
    try buf.appendSlice(alloc, "<InstancePort>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.instance_port}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</InstancePort>");
    if (value.instance_protocol) |v| {
        try buf.appendSlice(alloc, "<InstanceProtocol>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</InstanceProtocol>");
    }
    try buf.appendSlice(alloc, "<LoadBalancerPort>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.load_balancer_port}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</LoadBalancerPort>");
    try buf.appendSlice(alloc, "<Protocol>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.protocol);
    try buf.appendSlice(alloc, "</Protocol>");
    if (value.ssl_certificate_id) |v| {
        try buf.appendSlice(alloc, "<SSLCertificateId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SSLCertificateId>");
    }
}

pub fn serializeLoadBalancerAttributes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LoadBalancerAttributes) !void {
    if (value.access_log) |v| {
        try buf.appendSlice(alloc, "<AccessLog>");
        try serializeAccessLog(alloc, buf, v);
        try buf.appendSlice(alloc, "</AccessLog>");
    }
    if (value.additional_attributes) |v| {
        try buf.appendSlice(alloc, "<AdditionalAttributes>");
        try serializeAdditionalAttributes(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</AdditionalAttributes>");
    }
    if (value.connection_draining) |v| {
        try buf.appendSlice(alloc, "<ConnectionDraining>");
        try serializeConnectionDraining(alloc, buf, v);
        try buf.appendSlice(alloc, "</ConnectionDraining>");
    }
    if (value.connection_settings) |v| {
        try buf.appendSlice(alloc, "<ConnectionSettings>");
        try serializeConnectionSettings(alloc, buf, v);
        try buf.appendSlice(alloc, "</ConnectionSettings>");
    }
    if (value.cross_zone_load_balancing) |v| {
        try buf.appendSlice(alloc, "<CrossZoneLoadBalancing>");
        try serializeCrossZoneLoadBalancing(alloc, buf, v);
        try buf.appendSlice(alloc, "</CrossZoneLoadBalancing>");
    }
}

pub fn serializePolicyAttribute(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PolicyAttribute) !void {
    if (value.attribute_name) |v| {
        try buf.appendSlice(alloc, "<AttributeName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AttributeName>");
    }
    if (value.attribute_value) |v| {
        try buf.appendSlice(alloc, "<AttributeValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AttributeValue>");
    }
}

pub fn serializeTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(alloc, "<Key>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key);
    try buf.appendSlice(alloc, "</Key>");
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Value>");
    }
}

pub fn serializeTagKeyOnly(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TagKeyOnly) !void {
    if (value.key) |v| {
        try buf.appendSlice(alloc, "<Key>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Key>");
    }
}

