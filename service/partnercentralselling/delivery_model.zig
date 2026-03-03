const std = @import("std");

pub const DeliveryModel = enum {
    saas_or_paas,
    byol_or_ami,
    managed_services,
    professional_services,
    resell,
    other,

    pub const json_field_names = .{
        .saas_or_paas = "SaaS or PaaS",
        .byol_or_ami = "BYOL or AMI",
        .managed_services = "Managed Services",
        .professional_services = "Professional Services",
        .resell = "Resell",
        .other = "Other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .saas_or_paas => "SaaS or PaaS",
            .byol_or_ami => "BYOL or AMI",
            .managed_services => "Managed Services",
            .professional_services => "Professional Services",
            .resell => "Resell",
            .other => "Other",
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
