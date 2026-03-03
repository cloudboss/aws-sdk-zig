const std = @import("std");

pub const FieldNameString = enum {
    resource_arn,
    role_arn,
    last_modified,

    pub const json_field_names = .{
        .resource_arn = "RESOURCE_ARN",
        .role_arn = "ROLE_ARN",
        .last_modified = "LAST_MODIFIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_arn => "RESOURCE_ARN",
            .role_arn => "ROLE_ARN",
            .last_modified => "LAST_MODIFIED",
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
