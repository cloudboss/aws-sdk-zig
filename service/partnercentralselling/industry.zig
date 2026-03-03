const std = @import("std");

pub const Industry = enum {
    aerospace_satellite,
    agriculture,
    automotive,
    computers_electronics,
    consumer_goods,
    education,
    energy_oil_gas,
    energy_power_utilities,
    financial_services,
    gaming,
    government,
    healthcare,
    hospitality,
    life_sciences,
    manufacturing,
    marketing_advertising,
    media_entertainment,
    mining,
    non_profit_organization,
    professional_services,
    realestate_construction,
    retail,
    software_internet,
    telecommunications,
    transportation_logistics,
    travel,
    wholesale_distribution,
    other,

    pub const json_field_names = .{
        .aerospace_satellite = "Aerospace",
        .agriculture = "Agriculture",
        .automotive = "Automotive",
        .computers_electronics = "Computers and Electronics",
        .consumer_goods = "Consumer Goods",
        .education = "Education",
        .energy_oil_gas = "Energy - Oil and Gas",
        .energy_power_utilities = "Energy - Power and Utilities",
        .financial_services = "Financial Services",
        .gaming = "Gaming",
        .government = "Government",
        .healthcare = "Healthcare",
        .hospitality = "Hospitality",
        .life_sciences = "Life Sciences",
        .manufacturing = "Manufacturing",
        .marketing_advertising = "Marketing and Advertising",
        .media_entertainment = "Media and Entertainment",
        .mining = "Mining",
        .non_profit_organization = "Non-Profit Organization",
        .professional_services = "Professional Services",
        .realestate_construction = "Real Estate and Construction",
        .retail = "Retail",
        .software_internet = "Software and Internet",
        .telecommunications = "Telecommunications",
        .transportation_logistics = "Transportation and Logistics",
        .travel = "Travel",
        .wholesale_distribution = "Wholesale and Distribution",
        .other = "Other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aerospace_satellite => "Aerospace",
            .agriculture => "Agriculture",
            .automotive => "Automotive",
            .computers_electronics => "Computers and Electronics",
            .consumer_goods => "Consumer Goods",
            .education => "Education",
            .energy_oil_gas => "Energy - Oil and Gas",
            .energy_power_utilities => "Energy - Power and Utilities",
            .financial_services => "Financial Services",
            .gaming => "Gaming",
            .government => "Government",
            .healthcare => "Healthcare",
            .hospitality => "Hospitality",
            .life_sciences => "Life Sciences",
            .manufacturing => "Manufacturing",
            .marketing_advertising => "Marketing and Advertising",
            .media_entertainment => "Media and Entertainment",
            .mining => "Mining",
            .non_profit_organization => "Non-Profit Organization",
            .professional_services => "Professional Services",
            .realestate_construction => "Real Estate and Construction",
            .retail => "Retail",
            .software_internet => "Software and Internet",
            .telecommunications => "Telecommunications",
            .transportation_logistics => "Transportation and Logistics",
            .travel => "Travel",
            .wholesale_distribution => "Wholesale and Distribution",
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
