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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
