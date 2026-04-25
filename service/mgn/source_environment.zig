const std = @import("std");

pub const SourceEnvironment = enum {
    nsx,
    vsphere,
    fortigate_firewall,
    palo_alto_firewall,
    cisco_aci,
    logical_model,
    modelize_it,

    pub const json_field_names = .{
        .nsx = "NSX",
        .vsphere = "VSPHERE",
        .fortigate_firewall = "FORTIGATE_FIREWALL",
        .palo_alto_firewall = "PALO_ALTO_FIREWALL",
        .cisco_aci = "CISCO_ACI",
        .logical_model = "LOGICAL_MODEL",
        .modelize_it = "MODELIZE_IT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .nsx => "NSX",
            .vsphere => "VSPHERE",
            .fortigate_firewall => "FORTIGATE_FIREWALL",
            .palo_alto_firewall => "PALO_ALTO_FIREWALL",
            .cisco_aci => "CISCO_ACI",
            .logical_model => "LOGICAL_MODEL",
            .modelize_it => "MODELIZE_IT",
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
