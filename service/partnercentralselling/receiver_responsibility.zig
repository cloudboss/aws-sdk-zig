const std = @import("std");

pub const ReceiverResponsibility = enum {
    distributor,
    reseller,
    hardware_partner,
    managed_service_provider,
    software_partner,
    services_partner,
    training_partner,
    co_sell_facilitator,
    facilitator,

    pub const json_field_names = .{
        .distributor = "Distributor",
        .reseller = "Reseller",
        .hardware_partner = "Hardware Partner",
        .managed_service_provider = "Managed Service Provider",
        .software_partner = "Software Partner",
        .services_partner = "Services Partner",
        .training_partner = "Training Partner",
        .co_sell_facilitator = "Co-Sell Facilitator",
        .facilitator = "Facilitator",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .distributor => "Distributor",
            .reseller => "Reseller",
            .hardware_partner => "Hardware Partner",
            .managed_service_provider => "Managed Service Provider",
            .software_partner => "Software Partner",
            .services_partner => "Services Partner",
            .training_partner => "Training Partner",
            .co_sell_facilitator => "Co-Sell Facilitator",
            .facilitator => "Facilitator",
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
