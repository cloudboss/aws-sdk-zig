const std = @import("std");

pub const DataSourceStatus = enum {
    pending_creation,
    creating,
    active,
    deleting,
    failed,
    updating,

    pub const json_field_names = .{
        .pending_creation = "PENDING_CREATION",
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_creation => "PENDING_CREATION",
            .creating => "CREATING",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .failed => "FAILED",
            .updating => "UPDATING",
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
