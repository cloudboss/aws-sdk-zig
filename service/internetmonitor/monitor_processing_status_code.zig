const std = @import("std");

pub const MonitorProcessingStatusCode = enum {
    ok,
    inactive,
    collecting_data,
    insufficient_data,
    fault_service,
    fault_access_cloudwatch,

    pub const json_field_names = .{
        .ok = "OK",
        .inactive = "INACTIVE",
        .collecting_data = "COLLECTING_DATA",
        .insufficient_data = "INSUFFICIENT_DATA",
        .fault_service = "FAULT_SERVICE",
        .fault_access_cloudwatch = "FAULT_ACCESS_CLOUDWATCH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ok => "OK",
            .inactive => "INACTIVE",
            .collecting_data => "COLLECTING_DATA",
            .insufficient_data => "INSUFFICIENT_DATA",
            .fault_service => "FAULT_SERVICE",
            .fault_access_cloudwatch => "FAULT_ACCESS_CLOUDWATCH",
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
