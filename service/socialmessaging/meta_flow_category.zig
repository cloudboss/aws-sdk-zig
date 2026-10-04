const std = @import("std");

/// The category that classifies the business purpose of a WhatsApp Flow.
pub const MetaFlowCategory = enum {
    sign_up,
    sign_in,
    appointment_booking,
    lead_generation,
    shopping,
    contact_us,
    customer_support,
    survey,
    other,

    pub const json_field_names = .{
        .sign_up = "SIGN_UP",
        .sign_in = "SIGN_IN",
        .appointment_booking = "APPOINTMENT_BOOKING",
        .lead_generation = "LEAD_GENERATION",
        .shopping = "SHOPPING",
        .contact_us = "CONTACT_US",
        .customer_support = "CUSTOMER_SUPPORT",
        .survey = "SURVEY",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sign_up => "SIGN_UP",
            .sign_in => "SIGN_IN",
            .appointment_booking => "APPOINTMENT_BOOKING",
            .lead_generation => "LEAD_GENERATION",
            .shopping => "SHOPPING",
            .contact_us => "CONTACT_US",
            .customer_support => "CUSTOMER_SUPPORT",
            .survey => "SURVEY",
            .other => "OTHER",
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
