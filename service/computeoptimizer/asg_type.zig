const std = @import("std");

pub const AsgType = enum {
    single_instance_type,
    mixed_instance_type,

    pub const json_field_names = .{
        .single_instance_type = "SingleInstanceType",
        .mixed_instance_type = "MixedInstanceTypes",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_instance_type => "SingleInstanceType",
            .mixed_instance_type => "MixedInstanceTypes",
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
