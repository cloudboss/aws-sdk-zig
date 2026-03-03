const std = @import("std");

pub const EventClass = enum {
    infrastructure,
    deployment,
    security_change,
    config_change,
    schema_change,

    pub const json_field_names = .{
        .infrastructure = "INFRASTRUCTURE",
        .deployment = "DEPLOYMENT",
        .security_change = "SECURITY_CHANGE",
        .config_change = "CONFIG_CHANGE",
        .schema_change = "SCHEMA_CHANGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .infrastructure => "INFRASTRUCTURE",
            .deployment => "DEPLOYMENT",
            .security_change => "SECURITY_CHANGE",
            .config_change => "CONFIG_CHANGE",
            .schema_change => "SCHEMA_CHANGE",
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
