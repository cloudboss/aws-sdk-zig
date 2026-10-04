const std = @import("std");

pub const FirewallDomainRedirectionAction = enum {
    inspect_redirection_domain,
    trust_redirection_domain,

    pub const json_field_names = .{
        .inspect_redirection_domain = "INSPECT_REDIRECTION_DOMAIN",
        .trust_redirection_domain = "TRUST_REDIRECTION_DOMAIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inspect_redirection_domain => "INSPECT_REDIRECTION_DOMAIN",
            .trust_redirection_domain => "TRUST_REDIRECTION_DOMAIN",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
