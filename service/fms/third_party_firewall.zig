const std = @import("std");

pub const ThirdPartyFirewall = enum {
    palo_alto_networks_cloud_ngfw,
    fortigate_cloud_native_firewall,

    pub const json_field_names = .{
        .palo_alto_networks_cloud_ngfw = "PALO_ALTO_NETWORKS_CLOUD_NGFW",
        .fortigate_cloud_native_firewall = "FORTIGATE_CLOUD_NATIVE_FIREWALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .palo_alto_networks_cloud_ngfw => "PALO_ALTO_NETWORKS_CLOUD_NGFW",
            .fortigate_cloud_native_firewall => "FORTIGATE_CLOUD_NATIVE_FIREWALL",
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
