const std = @import("std");

/// The policy that determines when a node lifecycle script runs. Valid values:
///
/// * `FIRST_BOOT_ONLY` – Runs the script only the first time the compute node
///   boots.
/// * `EVERY_BOOT` – Runs the script every time the compute node boots,
///   including reboots.
pub const ExecutionPolicy = enum {
    first_boot_only,
    every_boot,

    pub const json_field_names = .{
        .first_boot_only = "FIRST_BOOT_ONLY",
        .every_boot = "EVERY_BOOT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .first_boot_only => "FIRST_BOOT_ONLY",
            .every_boot => "EVERY_BOOT",
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
