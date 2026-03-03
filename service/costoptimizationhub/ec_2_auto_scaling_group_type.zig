const std = @import("std");

pub const Ec2AutoScalingGroupType = enum {
    single_instance_type,
    mixed_instance_types,

    pub const json_field_names = .{
        .single_instance_type = "SingleInstanceType",
        .mixed_instance_types = "MixedInstanceTypes",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_instance_type => "SingleInstanceType",
            .mixed_instance_types => "MixedInstanceTypes",
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
