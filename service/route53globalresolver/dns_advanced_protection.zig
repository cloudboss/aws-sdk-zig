const std = @import("std");

pub const DnsAdvancedProtection = enum {
    dga,
    dns_tunneling,
    dictionary_dga,

    pub const json_field_names = .{
        .dga = "DGA",
        .dns_tunneling = "DNS_TUNNELING",
        .dictionary_dga = "DICTIONARY_DGA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dga => "DGA",
            .dns_tunneling => "DNS_TUNNELING",
            .dictionary_dga => "DICTIONARY_DGA",
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
