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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
