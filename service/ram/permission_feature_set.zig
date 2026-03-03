const std = @import("std");

pub const PermissionFeatureSet = enum {
    created_from_policy,
    promoting_to_standard,
    standard,

    pub const json_field_names = .{
        .created_from_policy = "CREATED_FROM_POLICY",
        .promoting_to_standard = "PROMOTING_TO_STANDARD",
        .standard = "STANDARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created_from_policy => "CREATED_FROM_POLICY",
            .promoting_to_standard => "PROMOTING_TO_STANDARD",
            .standard => "STANDARD",
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
