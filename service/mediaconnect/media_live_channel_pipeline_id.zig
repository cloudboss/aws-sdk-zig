const std = @import("std");

pub const MediaLiveChannelPipelineId = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
