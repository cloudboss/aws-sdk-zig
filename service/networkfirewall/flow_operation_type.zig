const std = @import("std");

pub const FlowOperationType = enum {
    flow_flush,
    flow_capture,

    pub const json_field_names = .{
        .flow_flush = "FLOW_FLUSH",
        .flow_capture = "FLOW_CAPTURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .flow_flush => "FLOW_FLUSH",
            .flow_capture => "FLOW_CAPTURE",
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
