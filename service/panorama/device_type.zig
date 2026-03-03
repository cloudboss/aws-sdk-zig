const std = @import("std");

pub const DeviceType = enum {
    panorama_appliance_developer_kit,
    panorama_appliance,

    pub const json_field_names = .{
        .panorama_appliance_developer_kit = "PANORAMA_APPLIANCE_DEVELOPER_KIT",
        .panorama_appliance = "PANORAMA_APPLIANCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .panorama_appliance_developer_kit => "PANORAMA_APPLIANCE_DEVELOPER_KIT",
            .panorama_appliance => "PANORAMA_APPLIANCE",
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
