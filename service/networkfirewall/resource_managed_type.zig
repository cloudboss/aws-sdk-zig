const std = @import("std");

pub const ResourceManagedType = enum {
    aws_managed_threat_signatures,
    aws_managed_domain_lists,
    active_threat_defense,
    partner_managed,

    pub const json_field_names = .{
        .aws_managed_threat_signatures = "AWS_MANAGED_THREAT_SIGNATURES",
        .aws_managed_domain_lists = "AWS_MANAGED_DOMAIN_LISTS",
        .active_threat_defense = "ACTIVE_THREAT_DEFENSE",
        .partner_managed = "PARTNER_MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_managed_threat_signatures => "AWS_MANAGED_THREAT_SIGNATURES",
            .aws_managed_domain_lists => "AWS_MANAGED_DOMAIN_LISTS",
            .active_threat_defense => "ACTIVE_THREAT_DEFENSE",
            .partner_managed => "PARTNER_MANAGED",
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
