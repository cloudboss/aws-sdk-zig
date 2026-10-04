const std = @import("std");

pub const JobSecondaryStatus = enum {
    starting,
    downloading,
    training,
    uploading,
    stopping,
    stopped,
    max_runtime_exceeded,
    interrupted,
    failed,
    completed,
    restarting,
    pending,
    evaluating,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .starting = "Starting",
        .downloading = "Downloading",
        .training = "Training",
        .uploading = "Uploading",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .max_runtime_exceeded = "MaxRuntimeExceeded",
        .interrupted = "Interrupted",
        .failed = "Failed",
        .completed = "Completed",
        .restarting = "Restarting",
        .pending = "Pending",
        .evaluating = "Evaluating",
        .deleting = "Deleting",
        .delete_failed = "DeleteFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .starting => "Starting",
            .downloading => "Downloading",
            .training => "Training",
            .uploading => "Uploading",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .max_runtime_exceeded => "MaxRuntimeExceeded",
            .interrupted => "Interrupted",
            .failed => "Failed",
            .completed => "Completed",
            .restarting => "Restarting",
            .pending => "Pending",
            .evaluating => "Evaluating",
            .deleting => "Deleting",
            .delete_failed => "DeleteFailed",
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
