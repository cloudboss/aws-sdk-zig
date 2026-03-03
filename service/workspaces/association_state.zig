const std = @import("std");

pub const AssociationState = enum {
    pending_install,
    pending_install_deployment,
    pending_uninstall,
    pending_uninstall_deployment,
    installing,
    uninstalling,
    @"error",
    completed,
    removed,

    pub const json_field_names = .{
        .pending_install = "PENDING_INSTALL",
        .pending_install_deployment = "PENDING_INSTALL_DEPLOYMENT",
        .pending_uninstall = "PENDING_UNINSTALL",
        .pending_uninstall_deployment = "PENDING_UNINSTALL_DEPLOYMENT",
        .installing = "INSTALLING",
        .uninstalling = "UNINSTALLING",
        .@"error" = "ERROR",
        .completed = "COMPLETED",
        .removed = "REMOVED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_install => "PENDING_INSTALL",
            .pending_install_deployment => "PENDING_INSTALL_DEPLOYMENT",
            .pending_uninstall => "PENDING_UNINSTALL",
            .pending_uninstall_deployment => "PENDING_UNINSTALL_DEPLOYMENT",
            .installing => "INSTALLING",
            .uninstalling => "UNINSTALLING",
            .@"error" => "ERROR",
            .completed => "COMPLETED",
            .removed => "REMOVED",
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
