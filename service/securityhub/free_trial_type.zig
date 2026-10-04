const std = @import("std");

pub const FreeTrialType = enum {
    security_hub_v2,
    security_hub_v2_multi_cloud_azure,

    pub const json_field_names = .{
        .security_hub_v2 = "SECURITY_HUB_V2",
        .security_hub_v2_multi_cloud_azure = "SECURITY_HUB_V2_MULTI_CLOUD_AZURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .security_hub_v2 => "SECURITY_HUB_V2",
            .security_hub_v2_multi_cloud_azure => "SECURITY_HUB_V2_MULTI_CLOUD_AZURE",
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
