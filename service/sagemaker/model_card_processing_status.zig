const std = @import("std");

pub const ModelCardProcessingStatus = enum {
    delete_inprogress,
    delete_pending,
    content_deleted,
    exportjobs_deleted,
    delete_completed,
    delete_failed,

    pub const json_field_names = .{
        .delete_inprogress = "DeleteInProgress",
        .delete_pending = "DeletePending",
        .content_deleted = "ContentDeleted",
        .exportjobs_deleted = "ExportJobsDeleted",
        .delete_completed = "DeleteCompleted",
        .delete_failed = "DeleteFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .delete_inprogress => "DeleteInProgress",
            .delete_pending => "DeletePending",
            .content_deleted => "ContentDeleted",
            .exportjobs_deleted => "ExportJobsDeleted",
            .delete_completed => "DeleteCompleted",
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
