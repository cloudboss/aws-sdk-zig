const std = @import("std");

pub const NniPartnerType = enum {
    v1,
    v2,
    non_partner,

    pub const json_field_names = .{
        .v1 = "v1",
        .v2 = "v2",
        .non_partner = "nonPartner",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .v1 => "v1",
            .v2 => "v2",
            .non_partner => "nonPartner",
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
