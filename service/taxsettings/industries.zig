const std = @import("std");

pub const Industries = enum {
    circulating_org,
    professional_org,
    banks,
    insurance,
    pension_and_benefit_funds,
    development_agencies,

    pub const json_field_names = .{
        .circulating_org = "CirculatingOrg",
        .professional_org = "ProfessionalOrg",
        .banks = "Banks",
        .insurance = "Insurance",
        .pension_and_benefit_funds = "PensionAndBenefitFunds",
        .development_agencies = "DevelopmentAgencies",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .circulating_org => "CirculatingOrg",
            .professional_org => "ProfessionalOrg",
            .banks => "Banks",
            .insurance => "Insurance",
            .pension_and_benefit_funds => "PensionAndBenefitFunds",
            .development_agencies => "DevelopmentAgencies",
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
