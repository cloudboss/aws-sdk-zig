const std = @import("std");

pub const EndpointStatus = enum {
    created,
    creating,
    deleted,
    deleting,
    failed,

    pub const json_field_names = .{
        .created = "created",
        .creating = "creating",
        .deleted = "deleted",
        .deleting = "deleting",
        .failed = "failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "created",
            .creating => "creating",
            .deleted => "deleted",
            .deleting => "deleting",
            .failed => "failed",
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
