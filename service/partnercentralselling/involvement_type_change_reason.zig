const std = @import("std");

pub const InvolvementTypeChangeReason = enum {
    expansion_opportunity,
    change_in_deal_information,
    customer_requested,
    technical_complexity,
    risk_mitigation,

    pub const json_field_names = .{
        .expansion_opportunity = "Expansion Opportunity",
        .change_in_deal_information = "Change in Deal Information",
        .customer_requested = "Customer Requested",
        .technical_complexity = "Technical Complexity",
        .risk_mitigation = "Risk Mitigation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .expansion_opportunity => "Expansion Opportunity",
            .change_in_deal_information => "Change in Deal Information",
            .customer_requested => "Customer Requested",
            .technical_complexity => "Technical Complexity",
            .risk_mitigation => "Risk Mitigation",
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
