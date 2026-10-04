const std = @import("std");

pub const BatchResourceRequirementType = enum {
    gpu,
    memory,
    vcpu,

    pub const json_field_names = .{
        .gpu = "GPU",
        .memory = "MEMORY",
        .vcpu = "VCPU",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gpu => "GPU",
            .memory => "MEMORY",
            .vcpu => "VCPU",
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
