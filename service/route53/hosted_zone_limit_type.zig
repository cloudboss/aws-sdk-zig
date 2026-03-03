const std = @import("std");

pub const HostedZoneLimitType = enum {
    max_rrsets_by_zone,
    max_vpcs_associated_by_zone,

    pub const json_field_names = .{
        .max_rrsets_by_zone = "MAX_RRSETS_BY_ZONE",
        .max_vpcs_associated_by_zone = "MAX_VPCS_ASSOCIATED_BY_ZONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .max_rrsets_by_zone => "MAX_RRSETS_BY_ZONE",
            .max_vpcs_associated_by_zone => "MAX_VPCS_ASSOCIATED_BY_ZONE",
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
