const std = @import("std");

pub const HubContentStatus = enum {
    available,
    importing,
    deleting,
    import_failed,
    delete_failed,
    pending_import,
    pending_delete,

    pub const json_field_names = .{
        .available = "Available",
        .importing = "Importing",
        .deleting = "Deleting",
        .import_failed = "ImportFailed",
        .delete_failed = "DeleteFailed",
        .pending_import = "PendingImport",
        .pending_delete = "PendingDelete",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "Available",
            .importing => "Importing",
            .deleting => "Deleting",
            .import_failed => "ImportFailed",
            .delete_failed => "DeleteFailed",
            .pending_import => "PendingImport",
            .pending_delete => "PendingDelete",
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
