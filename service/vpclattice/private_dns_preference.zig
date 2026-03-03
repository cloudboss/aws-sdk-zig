const std = @import("std");

pub const PrivateDnsPreference = enum {
    verified_domains_only,
    all_domains,
    verified_domains_and_specified_domains,
    specified_domains_only,

    pub const json_field_names = .{
        .verified_domains_only = "VERIFIED_DOMAINS_ONLY",
        .all_domains = "ALL_DOMAINS",
        .verified_domains_and_specified_domains = "VERIFIED_DOMAINS_AND_SPECIFIED_DOMAINS",
        .specified_domains_only = "SPECIFIED_DOMAINS_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .verified_domains_only => "VERIFIED_DOMAINS_ONLY",
            .all_domains => "ALL_DOMAINS",
            .verified_domains_and_specified_domains => "VERIFIED_DOMAINS_AND_SPECIFIED_DOMAINS",
            .specified_domains_only => "SPECIFIED_DOMAINS_ONLY",
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
