const std = @import("std");

pub const IndexState = enum {
    /// Resource Explorer is creating the index.
    creating,
    /// Index is active.
    active,
    /// Resource Explorer is deleting the index.
    deleting,
    /// Resource Explorer successfully deleted the index.
    deleted,
    /// Resource Explorer is switching the index type between local and aggregator.
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .deleted => "DELETED",
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
