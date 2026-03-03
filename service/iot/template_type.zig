const std = @import("std");

pub const TemplateType = enum {
    fleet_provisioning,
    jitp,

    pub const json_field_names = .{
        .fleet_provisioning = "FLEET_PROVISIONING",
        .jitp = "JITP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fleet_provisioning => "FLEET_PROVISIONING",
            .jitp => "JITP",
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
