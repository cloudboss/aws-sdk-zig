const std = @import("std");

pub const DomainControllerStatus = enum {
    creating,
    active,
    impaired,
    restoring,
    deleting,
    deleted,
    failed,
    updating,

    pub const json_field_names = .{
        .creating = "Creating",
        .active = "Active",
        .impaired = "Impaired",
        .restoring = "Restoring",
        .deleting = "Deleting",
        .deleted = "Deleted",
        .failed = "Failed",
        .updating = "Updating",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .active => "Active",
            .impaired => "Impaired",
            .restoring => "Restoring",
            .deleting => "Deleting",
            .deleted => "Deleted",
            .failed => "Failed",
            .updating => "Updating",
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
