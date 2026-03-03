const std = @import("std");

pub const SortPipelineExecutionsBy = enum {
    creation_time,
    pipeline_execution_arn,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .pipeline_execution_arn = "PipelineExecutionArn",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creation_time => "CreationTime",
            .pipeline_execution_arn => "PipelineExecutionArn",
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
