const std = @import("std");

pub const DriftIgnoredReason = enum {
    managed_by_aws,
    write_only_property,

    pub const json_field_names = .{
        .managed_by_aws = "MANAGED_BY_AWS",
        .write_only_property = "WRITE_ONLY_PROPERTY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .managed_by_aws => "MANAGED_BY_AWS",
            .write_only_property => "WRITE_ONLY_PROPERTY",
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
