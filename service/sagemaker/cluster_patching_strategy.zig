const std = @import("std");

/// The strategy for applying automatic patches to instances.
///
/// * `WhenIdle`: Cordons all instances and patches each instance as it becomes
///   idle (no running jobs). Each instance is uncordoned immediately after
///   patching and becomes available for new jobs. If instances do not become
///   idle, they remain on the previous AMI version. You can then use
///   UpdateClusterSoftware with the desired ImageReleaseVersion to manually
///   update the remaining instances.
/// * `WhenAllIdle`: Cordons all instances and waits for all to become idle
///   before patching. All instances are uncordoned after patching completes. If
///   not all instances become idle, no patching occurs and all instances remain
///   on the previous AMI version.
pub const ClusterPatchingStrategy = enum {
    when_idle,
    when_all_idle,

    pub const json_field_names = .{
        .when_idle = "WhenIdle",
        .when_all_idle = "WhenAllIdle",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .when_idle => "WhenIdle",
            .when_all_idle => "WhenAllIdle",
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
