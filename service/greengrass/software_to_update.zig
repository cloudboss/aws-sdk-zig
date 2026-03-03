const std = @import("std");

/// The piece of software on the Greengrass core that will be updated.
pub const SoftwareToUpdate = enum {
    core,
    ota_agent,

    pub const json_field_names = .{
        .core = "core",
        .ota_agent = "ota_agent",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .core => "core",
            .ota_agent => "ota_agent",
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
