const std = @import("std");

pub const AssociationExecutionFilterKey = enum {
    execution_id,
    status,
    created_time,

    pub const json_field_names = .{
        .execution_id = "ExecutionId",
        .status = "Status",
        .created_time = "CreatedTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .execution_id => "ExecutionId",
            .status => "Status",
            .created_time => "CreatedTime",
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
