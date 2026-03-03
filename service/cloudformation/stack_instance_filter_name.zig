const std = @import("std");

pub const StackInstanceFilterName = enum {
    detailed_status,
    last_operation_id,
    drift_status,

    pub const json_field_names = .{
        .detailed_status = "DETAILED_STATUS",
        .last_operation_id = "LAST_OPERATION_ID",
        .drift_status = "DRIFT_STATUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .detailed_status => "DETAILED_STATUS",
            .last_operation_id => "LAST_OPERATION_ID",
            .drift_status => "DRIFT_STATUS",
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
