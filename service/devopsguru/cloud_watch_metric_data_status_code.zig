const std = @import("std");

pub const CloudWatchMetricDataStatusCode = enum {
    complete,
    internal_error,
    partial_data,

    pub const json_field_names = .{
        .complete = "Complete",
        .internal_error = "InternalError",
        .partial_data = "PartialData",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .complete => "Complete",
            .internal_error => "InternalError",
            .partial_data => "PartialData",
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
