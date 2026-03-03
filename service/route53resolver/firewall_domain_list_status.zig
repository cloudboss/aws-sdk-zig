const std = @import("std");

pub const FirewallDomainListStatus = enum {
    complete,
    complete_import_failed,
    importing,
    deleting,
    updating,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .complete_import_failed = "COMPLETE_IMPORT_FAILED",
        .importing = "IMPORTING",
        .deleting = "DELETING",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .complete => "COMPLETE",
            .complete_import_failed => "COMPLETE_IMPORT_FAILED",
            .importing => "IMPORTING",
            .deleting => "DELETING",
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
