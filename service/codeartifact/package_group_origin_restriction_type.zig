const std = @import("std");

pub const PackageGroupOriginRestrictionType = enum {
    external_upstream,
    internal_upstream,
    publish,

    pub const json_field_names = .{
        .external_upstream = "EXTERNAL_UPSTREAM",
        .internal_upstream = "INTERNAL_UPSTREAM",
        .publish = "PUBLISH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .external_upstream => "EXTERNAL_UPSTREAM",
            .internal_upstream => "INTERNAL_UPSTREAM",
            .publish => "PUBLISH",
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
