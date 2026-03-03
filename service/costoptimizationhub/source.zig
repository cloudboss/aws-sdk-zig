const std = @import("std");

pub const Source = enum {
    compute_optimizer,
    cost_explorer,

    pub const json_field_names = .{
        .compute_optimizer = "ComputeOptimizer",
        .cost_explorer = "CostExplorer",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .compute_optimizer => "ComputeOptimizer",
            .cost_explorer => "CostExplorer",
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
