const std = @import("std");

pub const ProcurementPortalName = enum {
    sap_business_network,
    coupa,

    pub const json_field_names = .{
        .sap_business_network = "SAP_BUSINESS_NETWORK",
        .coupa = "COUPA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sap_business_network => "SAP_BUSINESS_NETWORK",
            .coupa => "COUPA",
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
