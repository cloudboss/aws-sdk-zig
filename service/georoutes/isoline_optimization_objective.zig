const std = @import("std");

pub const IsolineOptimizationObjective = enum {
    accurate_calculation,
    balanced_calculation,
    fast_calculation,

    pub const json_field_names = .{
        .accurate_calculation = "AccurateCalculation",
        .balanced_calculation = "BalancedCalculation",
        .fast_calculation = "FastCalculation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accurate_calculation => "AccurateCalculation",
            .balanced_calculation => "BalancedCalculation",
            .fast_calculation => "FastCalculation",
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
