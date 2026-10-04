const std = @import("std");

pub const QuoteConstraintType = enum {
    rack_maximum,
    rack_max_power_kva,
    rack_max_weight_lbs,
    rack_space_constrained,

    pub const json_field_names = .{
        .rack_maximum = "RACK_MAXIMUM",
        .rack_max_power_kva = "RACK_MAX_POWER_KVA",
        .rack_max_weight_lbs = "RACK_MAX_WEIGHT_LBS",
        .rack_space_constrained = "RACK_SPACE_CONSTRAINED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rack_maximum => "RACK_MAXIMUM",
            .rack_max_power_kva => "RACK_MAX_POWER_KVA",
            .rack_max_weight_lbs => "RACK_MAX_WEIGHT_LBS",
            .rack_space_constrained => "RACK_SPACE_CONSTRAINED",
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
