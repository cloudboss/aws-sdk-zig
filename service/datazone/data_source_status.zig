const std = @import("std");

pub const DataSourceStatus = enum {
    creating,
    failed_creation,
    ready,
    updating,
    failed_update,
    running,
    deleting,
    failed_deletion,

    pub const json_field_names = .{
        .creating = "CREATING",
        .failed_creation = "FAILED_CREATION",
        .ready = "READY",
        .updating = "UPDATING",
        .failed_update = "FAILED_UPDATE",
        .running = "RUNNING",
        .deleting = "DELETING",
        .failed_deletion = "FAILED_DELETION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .failed_creation => "FAILED_CREATION",
            .ready => "READY",
            .updating => "UPDATING",
            .failed_update => "FAILED_UPDATE",
            .running => "RUNNING",
            .deleting => "DELETING",
            .failed_deletion => "FAILED_DELETION",
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
