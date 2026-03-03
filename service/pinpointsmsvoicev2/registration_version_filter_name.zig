const std = @import("std");

pub const RegistrationVersionFilterName = enum {
    registration_version_status,

    pub const json_field_names = .{
        .registration_version_status = "registration-version-status",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .registration_version_status => "registration-version-status",
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
