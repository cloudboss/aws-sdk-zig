const std = @import("std");

/// The screen resolution for the agent streaming environment.
///
/// * W_1280xH_720 - 1280 x 720 pixels.
pub const ScreenResolution = enum {
    w_1280_x_h_720,

    pub const json_field_names = .{
        .w_1280_x_h_720 = "W_1280xH_720",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .w_1280_x_h_720 => "W_1280xH_720",
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
