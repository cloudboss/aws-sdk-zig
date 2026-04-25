const std = @import("std");

pub const TargetNetworkTopology = enum {
    isolated_vpc,
    hub_and_spoke,

    pub const json_field_names = .{
        .isolated_vpc = "ISOLATED_VPC",
        .hub_and_spoke = "HUB_AND_SPOKE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .isolated_vpc => "ISOLATED_VPC",
            .hub_and_spoke => "HUB_AND_SPOKE",
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
