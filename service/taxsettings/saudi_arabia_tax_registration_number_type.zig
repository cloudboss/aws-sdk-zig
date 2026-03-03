const std = @import("std");

pub const SaudiArabiaTaxRegistrationNumberType = enum {
    tax_registration_number,
    tax_identification_number,
    commercial_registration_number,

    pub const json_field_names = .{
        .tax_registration_number = "TaxRegistrationNumber",
        .tax_identification_number = "TaxIdentificationNumber",
        .commercial_registration_number = "CommercialRegistrationNumber",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tax_registration_number => "TaxRegistrationNumber",
            .tax_identification_number => "TaxIdentificationNumber",
            .commercial_registration_number => "CommercialRegistrationNumber",
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
