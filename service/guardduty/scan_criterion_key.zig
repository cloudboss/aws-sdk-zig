const std = @import("std");

/// An enum value representing possible resource properties to match with given
/// scan condition.
pub const ScanCriterionKey = enum {
    ec2_instance_tag,

    pub const json_field_names = .{
        .ec2_instance_tag = "EC2_INSTANCE_TAG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_instance_tag => "EC2_INSTANCE_TAG",
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
