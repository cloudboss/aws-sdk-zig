const std = @import("std");

pub const ImageBuilderState = enum {
    pending,
    updating_agent,
    running,
    stopping,
    stopped,
    rebooting,
    snapshotting,
    deleting,
    failed,
    updating,
    pending_qualification,
    pending_syncing_apps,
    syncing_apps,
    pending_image_import,

    pub const json_field_names = .{
        .pending = "PENDING",
        .updating_agent = "UPDATING_AGENT",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .rebooting = "REBOOTING",
        .snapshotting = "SNAPSHOTTING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .updating = "UPDATING",
        .pending_qualification = "PENDING_QUALIFICATION",
        .pending_syncing_apps = "PENDING_SYNCING_APPS",
        .syncing_apps = "SYNCING_APPS",
        .pending_image_import = "PENDING_IMAGE_IMPORT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .updating_agent => "UPDATING_AGENT",
            .running => "RUNNING",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .rebooting => "REBOOTING",
            .snapshotting => "SNAPSHOTTING",
            .deleting => "DELETING",
            .failed => "FAILED",
            .updating => "UPDATING",
            .pending_qualification => "PENDING_QUALIFICATION",
            .pending_syncing_apps => "PENDING_SYNCING_APPS",
            .syncing_apps => "SYNCING_APPS",
            .pending_image_import => "PENDING_IMAGE_IMPORT",
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
