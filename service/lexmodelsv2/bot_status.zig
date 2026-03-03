const std = @import("std");

pub const BotStatus = enum {
    creating,
    available,
    inactive,
    deleting,
    failed,
    versioning,
    importing,
    updating,

    pub const json_field_names = .{
        .creating = "Creating",
        .available = "Available",
        .inactive = "Inactive",
        .deleting = "Deleting",
        .failed = "Failed",
        .versioning = "Versioning",
        .importing = "Importing",
        .updating = "Updating",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .available => "Available",
            .inactive => "Inactive",
            .deleting => "Deleting",
            .failed => "Failed",
            .versioning => "Versioning",
            .importing => "Importing",
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
