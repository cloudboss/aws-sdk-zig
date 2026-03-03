const std = @import("std");

pub const ActiveDirectoryType = enum {
    /// SELF_MANAGED type of Active Directory
    self_managed,
    /// AWS_MANAGED type of Active Directory
    aws_managed,

    pub const json_field_names = .{
        .self_managed = "SELF_MANAGED",
        .aws_managed = "AWS_MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .self_managed => "SELF_MANAGED",
            .aws_managed => "AWS_MANAGED",
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
