const std = @import("std");

pub const SecurityServiceType = enum {
    waf,
    wafv2,
    shield_advanced,
    security_groups_common,
    security_groups_content_audit,
    security_groups_usage_audit,
    network_firewall,
    dns_firewall,
    third_party_firewall,
    import_network_firewall,
    network_acl_common,

    pub const json_field_names = .{
        .waf = "WAF",
        .wafv2 = "WAFV2",
        .shield_advanced = "SHIELD_ADVANCED",
        .security_groups_common = "SECURITY_GROUPS_COMMON",
        .security_groups_content_audit = "SECURITY_GROUPS_CONTENT_AUDIT",
        .security_groups_usage_audit = "SECURITY_GROUPS_USAGE_AUDIT",
        .network_firewall = "NETWORK_FIREWALL",
        .dns_firewall = "DNS_FIREWALL",
        .third_party_firewall = "THIRD_PARTY_FIREWALL",
        .import_network_firewall = "IMPORT_NETWORK_FIREWALL",
        .network_acl_common = "NETWORK_ACL_COMMON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .waf => "WAF",
            .wafv2 => "WAFV2",
            .shield_advanced => "SHIELD_ADVANCED",
            .security_groups_common => "SECURITY_GROUPS_COMMON",
            .security_groups_content_audit => "SECURITY_GROUPS_CONTENT_AUDIT",
            .security_groups_usage_audit => "SECURITY_GROUPS_USAGE_AUDIT",
            .network_firewall => "NETWORK_FIREWALL",
            .dns_firewall => "DNS_FIREWALL",
            .third_party_firewall => "THIRD_PARTY_FIREWALL",
            .import_network_firewall => "IMPORT_NETWORK_FIREWALL",
            .network_acl_common => "NETWORK_ACL_COMMON",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
