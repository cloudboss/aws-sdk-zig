const std = @import("std");

/// The output attachment type of the input device.
pub const InputDeviceOutputType = enum {
    none,
    medialive_input,
    mediaconnect_flow,

    pub const json_field_names = .{
        .none = "NONE",
        .medialive_input = "MEDIALIVE_INPUT",
        .mediaconnect_flow = "MEDIACONNECT_FLOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .medialive_input => "MEDIALIVE_INPUT",
            .mediaconnect_flow => "MEDIACONNECT_FLOW",
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
