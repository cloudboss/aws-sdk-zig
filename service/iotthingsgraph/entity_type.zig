const std = @import("std");

pub const EntityType = enum {
    device,
    service,
    device_model,
    capability,
    state,
    action,
    event,
    property,
    mapping,
    @"enum",

    pub const json_field_names = .{
        .device = "DEVICE",
        .service = "SERVICE",
        .device_model = "DEVICE_MODEL",
        .capability = "CAPABILITY",
        .state = "STATE",
        .action = "ACTION",
        .event = "EVENT",
        .property = "PROPERTY",
        .mapping = "MAPPING",
        .@"enum" = "ENUM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .device => "DEVICE",
            .service => "SERVICE",
            .device_model => "DEVICE_MODEL",
            .capability => "CAPABILITY",
            .state => "STATE",
            .action => "ACTION",
            .event => "EVENT",
            .property => "PROPERTY",
            .mapping => "MAPPING",
            .@"enum" => "ENUM",
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
