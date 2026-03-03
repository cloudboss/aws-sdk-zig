const std = @import("std");

/// The status of a document.
pub const DocumentStatus = enum {
    creating,
    active,
    updating,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "Creating",
        .active = "Active",
        .updating = "Updating",
        .deleting = "Deleting",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .active => "Active",
            .updating => "Updating",
            .deleting => "Deleting",
            .failed => "Failed",
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
