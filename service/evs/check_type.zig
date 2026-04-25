const std = @import("std");

pub const CheckType = enum {
    key_reuse,
    key_coverage,
    reachability,
    host_count,
    vcenter_reachability,
    vcenter_vm_sync,
    vcenter_vm_event,

    pub const json_field_names = .{
        .key_reuse = "KEY_REUSE",
        .key_coverage = "KEY_COVERAGE",
        .reachability = "REACHABILITY",
        .host_count = "HOST_COUNT",
        .vcenter_reachability = "VCENTER_REACHABILITY",
        .vcenter_vm_sync = "VCENTER_VM_SYNC",
        .vcenter_vm_event = "VCENTER_VM_EVENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .key_reuse => "KEY_REUSE",
            .key_coverage => "KEY_COVERAGE",
            .reachability => "REACHABILITY",
            .host_count => "HOST_COUNT",
            .vcenter_reachability => "VCENTER_REACHABILITY",
            .vcenter_vm_sync => "VCENTER_VM_SYNC",
            .vcenter_vm_event => "VCENTER_VM_EVENT",
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
