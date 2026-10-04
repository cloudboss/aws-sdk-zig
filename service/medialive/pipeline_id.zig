const std = @import("std");

/// Pipeline ID
pub const PipelineId = enum {
    pipeline_0,
    pipeline_1,

    pub const json_field_names = .{
        .pipeline_0 = "PIPELINE_0",
        .pipeline_1 = "PIPELINE_1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pipeline_0 => "PIPELINE_0",
            .pipeline_1 => "PIPELINE_1",
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
