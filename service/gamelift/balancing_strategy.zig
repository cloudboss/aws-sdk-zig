const std = @import("std");

pub const BalancingStrategy = enum {
    spot_only,
    spot_preferred,
    on_demand_only,

    pub const json_field_names = .{
        .spot_only = "SPOT_ONLY",
        .spot_preferred = "SPOT_PREFERRED",
        .on_demand_only = "ON_DEMAND_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .spot_only => "SPOT_ONLY",
            .spot_preferred => "SPOT_PREFERRED",
            .on_demand_only => "ON_DEMAND_ONLY",
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
