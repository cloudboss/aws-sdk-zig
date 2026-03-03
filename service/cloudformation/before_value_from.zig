const std = @import("std");

pub const BeforeValueFrom = enum {
    previous_deployment_state,
    actual_state,

    pub const json_field_names = .{
        .previous_deployment_state = "PREVIOUS_DEPLOYMENT_STATE",
        .actual_state = "ACTUAL_STATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .previous_deployment_state => "PREVIOUS_DEPLOYMENT_STATE",
            .actual_state => "ACTUAL_STATE",
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
