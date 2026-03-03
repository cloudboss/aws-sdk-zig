const std = @import("std");

pub const BotRecommendationStatus = enum {
    processing,
    deleting,
    deleted,
    downloading,
    updating,
    available,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .processing = "Processing",
        .deleting = "Deleting",
        .deleted = "Deleted",
        .downloading = "Downloading",
        .updating = "Updating",
        .available = "Available",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .processing => "Processing",
            .deleting => "Deleting",
            .deleted => "Deleted",
            .downloading => "Downloading",
            .updating => "Updating",
            .available => "Available",
            .failed => "Failed",
            .stopping => "Stopping",
            .stopped => "Stopped",
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
