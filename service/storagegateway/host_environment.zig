const std = @import("std");

pub const HostEnvironment = enum {
    vmware,
    hyper_v,
    ec2,
    kvm,
    other,
    snowball,

    pub const json_field_names = .{
        .vmware = "VMWARE",
        .hyper_v = "HYPER-V",
        .ec2 = "EC2",
        .kvm = "KVM",
        .other = "OTHER",
        .snowball = "SNOWBALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vmware => "VMWARE",
            .hyper_v => "HYPER-V",
            .ec2 => "EC2",
            .kvm => "KVM",
            .other => "OTHER",
            .snowball => "SNOWBALL",
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
