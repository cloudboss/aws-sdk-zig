const std = @import("std");

pub const UserdataType = enum {
    eks_bootstrap_sh,
    eks_nodeadm,

    pub const json_field_names = .{
        .eks_bootstrap_sh = "EKS_BOOTSTRAP_SH",
        .eks_nodeadm = "EKS_NODEADM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eks_bootstrap_sh => "EKS_BOOTSTRAP_SH",
            .eks_nodeadm => "EKS_NODEADM",
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
