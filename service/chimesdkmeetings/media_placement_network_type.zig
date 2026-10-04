const std = @import("std");

pub const MediaPlacementNetworkType = enum {
    ipv4_only,
    dual_stack,

    pub const json_field_names = .{
        .ipv4_only = "Ipv4Only",
        .dual_stack = "DualStack",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ipv4_only => "Ipv4Only",
            .dual_stack => "DualStack",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
