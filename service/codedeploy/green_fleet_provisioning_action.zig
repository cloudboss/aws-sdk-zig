const std = @import("std");

pub const GreenFleetProvisioningAction = enum {
    discover_existing,
    copy_auto_scaling_group,

    pub const json_field_names = .{
        .discover_existing = "DISCOVER_EXISTING",
        .copy_auto_scaling_group = "COPY_AUTO_SCALING_GROUP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .discover_existing => "DISCOVER_EXISTING",
            .copy_auto_scaling_group => "COPY_AUTO_SCALING_GROUP",
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
