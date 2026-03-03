const std = @import("std");

pub const ScheduledActionTypeValues = enum {
    resize_cluster,
    pause_cluster,
    resume_cluster,

    pub const json_field_names = .{
        .resize_cluster = "ResizeCluster",
        .pause_cluster = "PauseCluster",
        .resume_cluster = "ResumeCluster",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resize_cluster => "ResizeCluster",
            .pause_cluster => "PauseCluster",
            .resume_cluster => "ResumeCluster",
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
