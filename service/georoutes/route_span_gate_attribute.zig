const std = @import("std");

pub const RouteSpanGateAttribute = enum {
    emergency,
    key_access,
    permission_required,

    pub const json_field_names = .{
        .emergency = "Emergency",
        .key_access = "KeyAccess",
        .permission_required = "PermissionRequired",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .emergency => "Emergency",
            .key_access => "KeyAccess",
            .permission_required => "PermissionRequired",
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
