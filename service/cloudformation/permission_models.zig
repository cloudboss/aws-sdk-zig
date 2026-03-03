const std = @import("std");

pub const PermissionModels = enum {
    service_managed,
    self_managed,

    pub const json_field_names = .{
        .service_managed = "SERVICE_MANAGED",
        .self_managed = "SELF_MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_managed => "SERVICE_MANAGED",
            .self_managed => "SELF_MANAGED",
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
