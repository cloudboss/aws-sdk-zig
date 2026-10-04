const std = @import("std");

/// Data types that can be exported from a dataset.
pub const ExportDataType = enum {
    video,
    telemetry,
    annotation,

    pub const json_field_names = .{
        .video = "VIDEO",
        .telemetry = "TELEMETRY",
        .annotation = "ANNOTATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .video => "VIDEO",
            .telemetry => "TELEMETRY",
            .annotation => "ANNOTATION",
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
