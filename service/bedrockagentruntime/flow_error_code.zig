const std = @import("std");

pub const FlowErrorCode = enum {
    validation,
    internal_server,
    node_execution_failed,

    pub const json_field_names = .{
        .validation = "VALIDATION",
        .internal_server = "INTERNAL_SERVER",
        .node_execution_failed = "NODE_EXECUTION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validation => "VALIDATION",
            .internal_server => "INTERNAL_SERVER",
            .node_execution_failed => "NODE_EXECUTION_FAILED",
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
