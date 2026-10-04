const std = @import("std");

pub const S3AccessPointAttachmentLifecycle = enum {
    available,
    creating,
    deleting,
    updating,
    failed,
    misconfigured,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .failed = "FAILED",
        .misconfigured = "MISCONFIGURED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .creating => "CREATING",
            .deleting => "DELETING",
            .updating => "UPDATING",
            .failed => "FAILED",
            .misconfigured => "MISCONFIGURED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
