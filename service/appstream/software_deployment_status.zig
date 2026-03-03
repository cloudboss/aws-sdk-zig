const std = @import("std");

pub const SoftwareDeploymentStatus = enum {
    staged_for_installation,
    pending_installation,
    installed,
    staged_for_uninstallation,
    pending_uninstallation,
    failed_to_install,
    failed_to_uninstall,

    pub const json_field_names = .{
        .staged_for_installation = "STAGED_FOR_INSTALLATION",
        .pending_installation = "PENDING_INSTALLATION",
        .installed = "INSTALLED",
        .staged_for_uninstallation = "STAGED_FOR_UNINSTALLATION",
        .pending_uninstallation = "PENDING_UNINSTALLATION",
        .failed_to_install = "FAILED_TO_INSTALL",
        .failed_to_uninstall = "FAILED_TO_UNINSTALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .staged_for_installation => "STAGED_FOR_INSTALLATION",
            .pending_installation => "PENDING_INSTALLATION",
            .installed => "INSTALLED",
            .staged_for_uninstallation => "STAGED_FOR_UNINSTALLATION",
            .pending_uninstallation => "PENDING_UNINSTALLATION",
            .failed_to_install => "FAILED_TO_INSTALL",
            .failed_to_uninstall => "FAILED_TO_UNINSTALL",
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
