const std = @import("std");

/// The type of data source of an export, can be one of the following:
///
/// * `METRICS_DATA` - The metrics export.
///
/// * `MESSAGE_INSIGHTS` - The Message Insights export.
pub const ExportSourceType = enum {
    metrics_data,
    message_insights,

    pub const json_field_names = .{
        .metrics_data = "METRICS_DATA",
        .message_insights = "MESSAGE_INSIGHTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .metrics_data => "METRICS_DATA",
            .message_insights => "MESSAGE_INSIGHTS",
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
