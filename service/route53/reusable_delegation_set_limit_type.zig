const std = @import("std");

pub const ReusableDelegationSetLimitType = enum {
    max_zones_by_reusable_delegation_set,

    pub const json_field_names = .{
        .max_zones_by_reusable_delegation_set = "MAX_ZONES_BY_REUSABLE_DELEGATION_SET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .max_zones_by_reusable_delegation_set => "MAX_ZONES_BY_REUSABLE_DELEGATION_SET",
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
