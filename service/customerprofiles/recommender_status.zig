const std = @import("std");

pub const RecommenderStatus = enum {
    pending,
    in_progress,
    active,
    failed,
    stopping,
    inactive,
    starting,
    deleting,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .active = "ACTIVE",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .inactive = "INACTIVE",
        .starting = "STARTING",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_progress => "IN_PROGRESS",
            .active => "ACTIVE",
            .failed => "FAILED",
            .stopping => "STOPPING",
            .inactive => "INACTIVE",
            .starting => "STARTING",
            .deleting => "DELETING",
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
