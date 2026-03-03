const std = @import("std");

pub const SecondaryStatus = enum {
    starting,
    launching_ml_instances,
    preparing_training_stack,
    downloading,
    downloading_training_image,
    training,
    uploading,
    stopping,
    stopped,
    max_runtime_exceeded,
    completed,
    failed,
    interrupted,
    max_wait_time_exceeded,
    updating,
    restarting,
    pending,

    pub const json_field_names = .{
        .starting = "Starting",
        .launching_ml_instances = "LaunchingMLInstances",
        .preparing_training_stack = "PreparingTrainingStack",
        .downloading = "Downloading",
        .downloading_training_image = "DownloadingTrainingImage",
        .training = "Training",
        .uploading = "Uploading",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .max_runtime_exceeded = "MaxRuntimeExceeded",
        .completed = "Completed",
        .failed = "Failed",
        .interrupted = "Interrupted",
        .max_wait_time_exceeded = "MaxWaitTimeExceeded",
        .updating = "Updating",
        .restarting = "Restarting",
        .pending = "Pending",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .starting => "Starting",
            .launching_ml_instances => "LaunchingMLInstances",
            .preparing_training_stack => "PreparingTrainingStack",
            .downloading => "Downloading",
            .downloading_training_image => "DownloadingTrainingImage",
            .training => "Training",
            .uploading => "Uploading",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .max_runtime_exceeded => "MaxRuntimeExceeded",
            .completed => "Completed",
            .failed => "Failed",
            .interrupted => "Interrupted",
            .max_wait_time_exceeded => "MaxWaitTimeExceeded",
            .updating => "Updating",
            .restarting => "Restarting",
            .pending => "Pending",
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
