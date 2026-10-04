const std = @import("std");

pub const ComputeMode = enum {
    on_demand,
    provisioned,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .provisioned = "PROVISIONED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_demand => "ON_DEMAND",
            .provisioned => "PROVISIONED",
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
