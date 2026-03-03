const std = @import("std");

pub const AccessEndpointType = enum {
    streaming_wsp,

    pub const json_field_names = .{
        .streaming_wsp = "STREAMING_WSP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .streaming_wsp => "STREAMING_WSP",
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
