const std = @import("std");

pub const AgentManagedRuntimeType = enum {
    python_3_10,
    python_3_11,
    python_3_12,
    python_3_13,

    pub const json_field_names = .{
        .python_3_10 = "PYTHON_3_10",
        .python_3_11 = "PYTHON_3_11",
        .python_3_12 = "PYTHON_3_12",
        .python_3_13 = "PYTHON_3_13",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .python_3_10 => "PYTHON_3_10",
            .python_3_11 => "PYTHON_3_11",
            .python_3_12 => "PYTHON_3_12",
            .python_3_13 => "PYTHON_3_13",
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
