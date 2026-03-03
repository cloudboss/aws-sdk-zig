const std = @import("std");

pub const StartReplicationMigrationTypeValue = enum {
    reload_target,
    resume_processing,
    start_replication,

    pub const json_field_names = .{
        .reload_target = "reload-target",
        .resume_processing = "resume-processing",
        .start_replication = "start-replication",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reload_target => "reload-target",
            .resume_processing => "resume-processing",
            .start_replication => "start-replication",
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
