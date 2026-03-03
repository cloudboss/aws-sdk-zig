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

pub fn deserializeAdditionalAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AdditionalAttribute {
    var list: std.ArrayList(AdditionalAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAdditionalAttribute(allocator, reader));
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

pub fn deserializeAppCookieStickinessPolicies(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AppCookieStickinessPolicy {
    var list: std.ArrayList(AppCookieStickinessPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAppCookieStickinessPolicy(allocator, reader));
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

pub fn deserializeAvailabilityZones(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeBackendServerDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const BackendServerDescription {
    var list: std.ArrayList(BackendServerDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeBackendServerDescription(allocator, reader));
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

pub fn deserializeInstanceStates(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InstanceState {
    var list: std.ArrayList(InstanceState) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInstanceState(allocator, reader));
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

pub fn deserializeInstances(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Instance {
    var list: std.ArrayList(Instance) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInstance(allocator, reader));
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

pub fn deserializeLBCookieStickinessPolicies(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LBCookieStickinessPolicy {
    var list: std.ArrayList(LBCookieStickinessPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLBCookieStickinessPolicy(allocator, reader));
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

pub fn deserializeLimits(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Limit {
    var list: std.ArrayList(Limit) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLimit(allocator, reader));
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

pub fn deserializeListenerDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ListenerDescription {
    var list: std.ArrayList(ListenerDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeListenerDescription(allocator, reader));
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

pub fn deserializeLoadBalancerDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LoadBalancerDescription {
    var list: std.ArrayList(LoadBalancerDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLoadBalancerDescription(allocator, reader));
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

pub fn deserializePolicyAttributeDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyAttributeDescription {
    var list: std.ArrayList(PolicyAttributeDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyAttributeDescription(allocator, reader));
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

pub fn deserializePolicyAttributeTypeDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyAttributeTypeDescription {
    var list: std.ArrayList(PolicyAttributeTypeDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyAttributeTypeDescription(allocator, reader));
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

pub fn deserializePolicyDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyDescription {
    var list: std.ArrayList(PolicyDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyDescription(allocator, reader));
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

pub fn deserializePolicyNames(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializePolicyTypeDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyTypeDescription {
    var list: std.ArrayList(PolicyTypeDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyTypeDescription(allocator, reader));
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

pub fn deserializeSecurityGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSubnets(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTagDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TagDescription {
    var list: std.ArrayList(TagDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTagDescription(allocator, reader));
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

pub fn deserializeAccessLog(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccessLog {
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
                    result.s3_bucket_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3BucketPrefix")) {
                    result.s3_bucket_prefix = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAdditionalAttribute(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AdditionalAttribute {
    var result: AdditionalAttribute = undefined;
    result.key = null;
    result.value = null;
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

pub fn deserializeAppCookieStickinessPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AppCookieStickinessPolicy {
    var result: AppCookieStickinessPolicy = undefined;
    result.cookie_name = null;
    result.policy_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CookieName")) {
                    result.cookie_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeBackendServerDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BackendServerDescription {
    var result: BackendServerDescription = undefined;
    result.instance_port = null;
    result.policy_names = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstancePort")) {
                    result.instance_port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PolicyNames")) {
                    result.policy_names = try deserializePolicyNames(allocator, reader, "member");
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

pub fn deserializeConnectionDraining(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConnectionDraining {
    _ = allocator;
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

pub fn deserializeConnectionSettings(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConnectionSettings {
    _ = allocator;
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

pub fn deserializeCrossZoneLoadBalancing(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CrossZoneLoadBalancing {
    _ = allocator;
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

pub fn deserializeHealthCheck(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HealthCheck {
    var result: HealthCheck = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HealthyThreshold")) {
                    result.healthy_threshold = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Interval")) {
                    result.interval = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Target")) {
                    result.target = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeInstance(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Instance {
    var result: Instance = undefined;
    result.instance_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstanceId")) {
                    result.instance_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeInstanceState(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceState {
    var result: InstanceState = undefined;
    result.description = null;
    result.instance_id = null;
    result.reason_code = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceId")) {
                    result.instance_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReasonCode")) {
                    result.reason_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLBCookieStickinessPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LBCookieStickinessPolicy {
    var result: LBCookieStickinessPolicy = undefined;
    result.cookie_expiration_period = null;
    result.policy_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CookieExpirationPeriod")) {
                    result.cookie_expiration_period = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLimit(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Limit {
    var result: Limit = undefined;
    result.max = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeListener(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Listener {
    var result: Listener = undefined;
    result.instance_protocol = null;
    result.ssl_certificate_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstancePort")) {
                    result.instance_port = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "InstanceProtocol")) {
                    result.instance_protocol = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LoadBalancerPort")) {
                    result.load_balancer_port = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SSLCertificateId")) {
                    result.ssl_certificate_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeListenerDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ListenerDescription {
    var result: ListenerDescription = undefined;
    result.listener = null;
    result.policy_names = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Listener")) {
                    result.listener = try deserializeListener(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PolicyNames")) {
                    result.policy_names = try deserializePolicyNames(allocator, reader, "member");
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

pub fn deserializeLoadBalancerAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadBalancerAttributes {
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
                    result.access_log = try deserializeAccessLog(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AdditionalAttributes")) {
                    result.additional_attributes = try deserializeAdditionalAttributes(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ConnectionDraining")) {
                    result.connection_draining = try deserializeConnectionDraining(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ConnectionSettings")) {
                    result.connection_settings = try deserializeConnectionSettings(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CrossZoneLoadBalancing")) {
                    result.cross_zone_load_balancing = try deserializeCrossZoneLoadBalancing(allocator, reader);
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

pub fn deserializeLoadBalancerDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadBalancerDescription {
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
                    result.availability_zones = try deserializeAvailabilityZones(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "BackendServerDescriptions")) {
                    result.backend_server_descriptions = try deserializeBackendServerDescriptions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "CanonicalHostedZoneName")) {
                    result.canonical_hosted_zone_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CanonicalHostedZoneNameID")) {
                    result.canonical_hosted_zone_name_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DNSName")) {
                    result.dns_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthCheck")) {
                    result.health_check = try deserializeHealthCheck(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Instances")) {
                    result.instances = try deserializeInstances(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ListenerDescriptions")) {
                    result.listener_descriptions = try deserializeListenerDescriptions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Policies")) {
                    result.policies = try deserializePolicies(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Scheme")) {
                    result.scheme = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecurityGroups")) {
                    result.security_groups = try deserializeSecurityGroups(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SourceSecurityGroup")) {
                    result.source_security_group = try deserializeSourceSecurityGroup(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Subnets")) {
                    result.subnets = try deserializeSubnets(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "VPCId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicies(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Policies {
    var result: Policies = undefined;
    result.app_cookie_stickiness_policies = null;
    result.lb_cookie_stickiness_policies = null;
    result.other_policies = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AppCookieStickinessPolicies")) {
                    result.app_cookie_stickiness_policies = try deserializeAppCookieStickinessPolicies(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LBCookieStickinessPolicies")) {
                    result.lb_cookie_stickiness_policies = try deserializeLBCookieStickinessPolicies(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "OtherPolicies")) {
                    result.other_policies = try deserializePolicyNames(allocator, reader, "member");
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

pub fn deserializePolicyAttributeDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyAttributeDescription {
    var result: PolicyAttributeDescription = undefined;
    result.attribute_name = null;
    result.attribute_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AttributeName")) {
                    result.attribute_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeValue")) {
                    result.attribute_value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicyAttributeTypeDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyAttributeTypeDescription {
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
                    result.attribute_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeType")) {
                    result.attribute_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Cardinality")) {
                    result.cardinality = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicyDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyDescription {
    var result: PolicyDescription = undefined;
    result.policy_attribute_descriptions = null;
    result.policy_name = null;
    result.policy_type_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PolicyAttributeDescriptions")) {
                    result.policy_attribute_descriptions = try deserializePolicyAttributeDescriptions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyTypeName")) {
                    result.policy_type_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicyTypeDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyTypeDescription {
    var result: PolicyTypeDescription = undefined;
    result.description = null;
    result.policy_attribute_type_descriptions = null;
    result.policy_type_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyAttributeTypeDescriptions")) {
                    result.policy_attribute_type_descriptions = try deserializePolicyAttributeTypeDescriptions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PolicyTypeName")) {
                    result.policy_type_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeSourceSecurityGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SourceSecurityGroup {
    var result: SourceSecurityGroup = undefined;
    result.group_name = null;
    result.owner_alias = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GroupName")) {
                    result.group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OwnerAlias")) {
                    result.owner_alias = try allocator.dupe(u8, try reader.readElementText());
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
    result.value = null;
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

pub fn deserializeTagDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TagDescription {
    var result: TagDescription = undefined;
    result.load_balancer_name = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "member");
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

pub fn serializeAdditionalAttributes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AdditionalAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeAdditionalAttribute(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAvailabilityZones(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeInstances(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Instance, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeInstance(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeListeners(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Listener, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeListener(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeLoadBalancerNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLoadBalancerNamesMax20(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePolicyAttributes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PolicyAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializePolicyAttribute(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializePolicyNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePolicyTypeNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePorts(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const i32, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{item}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSecurityGroups(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeSubnets(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTagKeyList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TagKeyOnly, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTagKeyOnly(allocator, buf, item);
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

pub fn serializeAccessLog(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccessLog) !void {
    if (value.emit_interval) |v| {
        try buf.appendSlice(allocator, "<EmitInterval>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</EmitInterval>");
    }
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.s3_bucket_name) |v| {
        try buf.appendSlice(allocator, "<S3BucketName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3BucketName>");
    }
    if (value.s3_bucket_prefix) |v| {
        try buf.appendSlice(allocator, "<S3BucketPrefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3BucketPrefix>");
    }
}

pub fn serializeAdditionalAttribute(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AdditionalAttribute) !void {
    if (value.key) |v| {
        try buf.appendSlice(allocator, "<Key>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Key>");
    }
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeConnectionDraining(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectionDraining) !void {
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.timeout) |v| {
        try buf.appendSlice(allocator, "<Timeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Timeout>");
    }
}

pub fn serializeConnectionSettings(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectionSettings) !void {
    try buf.appendSlice(allocator, "<IdleTimeout>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.idle_timeout}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</IdleTimeout>");
}

pub fn serializeCrossZoneLoadBalancing(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CrossZoneLoadBalancing) !void {
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
}

pub fn serializeHealthCheck(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: HealthCheck) !void {
    try buf.appendSlice(allocator, "<HealthyThreshold>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.healthy_threshold}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</HealthyThreshold>");
    try buf.appendSlice(allocator, "<Interval>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.interval}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Interval>");
    try buf.appendSlice(allocator, "<Target>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.target);
    try buf.appendSlice(allocator, "</Target>");
    try buf.appendSlice(allocator, "<Timeout>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.timeout}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Timeout>");
    try buf.appendSlice(allocator, "<UnhealthyThreshold>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.unhealthy_threshold}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</UnhealthyThreshold>");
}

pub fn serializeInstance(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Instance) !void {
    if (value.instance_id) |v| {
        try buf.appendSlice(allocator, "<InstanceId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</InstanceId>");
    }
}

pub fn serializeListener(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Listener) !void {
    try buf.appendSlice(allocator, "<InstancePort>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.instance_port}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</InstancePort>");
    if (value.instance_protocol) |v| {
        try buf.appendSlice(allocator, "<InstanceProtocol>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</InstanceProtocol>");
    }
    try buf.appendSlice(allocator, "<LoadBalancerPort>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.load_balancer_port}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</LoadBalancerPort>");
    try buf.appendSlice(allocator, "<Protocol>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.protocol);
    try buf.appendSlice(allocator, "</Protocol>");
    if (value.ssl_certificate_id) |v| {
        try buf.appendSlice(allocator, "<SSLCertificateId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SSLCertificateId>");
    }
}

pub fn serializeLoadBalancerAttributes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LoadBalancerAttributes) !void {
    if (value.access_log) |v| {
        try buf.appendSlice(allocator, "<AccessLog>");
        try serializeAccessLog(allocator, buf, v);
        try buf.appendSlice(allocator, "</AccessLog>");
    }
    if (value.additional_attributes) |v| {
        try buf.appendSlice(allocator, "<AdditionalAttributes>");
        try serializeAdditionalAttributes(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</AdditionalAttributes>");
    }
    if (value.connection_draining) |v| {
        try buf.appendSlice(allocator, "<ConnectionDraining>");
        try serializeConnectionDraining(allocator, buf, v);
        try buf.appendSlice(allocator, "</ConnectionDraining>");
    }
    if (value.connection_settings) |v| {
        try buf.appendSlice(allocator, "<ConnectionSettings>");
        try serializeConnectionSettings(allocator, buf, v);
        try buf.appendSlice(allocator, "</ConnectionSettings>");
    }
    if (value.cross_zone_load_balancing) |v| {
        try buf.appendSlice(allocator, "<CrossZoneLoadBalancing>");
        try serializeCrossZoneLoadBalancing(allocator, buf, v);
        try buf.appendSlice(allocator, "</CrossZoneLoadBalancing>");
    }
}

pub fn serializePolicyAttribute(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PolicyAttribute) !void {
    if (value.attribute_name) |v| {
        try buf.appendSlice(allocator, "<AttributeName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AttributeName>");
    }
    if (value.attribute_value) |v| {
        try buf.appendSlice(allocator, "<AttributeValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AttributeValue>");
    }
}

pub fn serializeTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeTagKeyOnly(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TagKeyOnly) !void {
    if (value.key) |v| {
        try buf.appendSlice(allocator, "<Key>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Key>");
    }
}

