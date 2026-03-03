const std = @import("std");

pub const PrimarySolutionType = enum {
    software_products,
    consulting_services,
    professional_services,
    managed_services,
    hardware_products,
    communication_services,
    value_added_resale_aws_services,
    training_services,

    pub const json_field_names = .{
        .software_products = "SOFTWARE_PRODUCTS",
        .consulting_services = "CONSULTING_SERVICES",
        .professional_services = "PROFESSIONAL_SERVICES",
        .managed_services = "MANAGED_SERVICES",
        .hardware_products = "HARDWARE_PRODUCTS",
        .communication_services = "COMMUNICATION_SERVICES",
        .value_added_resale_aws_services = "VALUE_ADDED_RESALE_AWS_SERVICES",
        .training_services = "TRAINING_SERVICES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .software_products => "SOFTWARE_PRODUCTS",
            .consulting_services => "CONSULTING_SERVICES",
            .professional_services => "PROFESSIONAL_SERVICES",
            .managed_services => "MANAGED_SERVICES",
            .hardware_products => "HARDWARE_PRODUCTS",
            .communication_services => "COMMUNICATION_SERVICES",
            .value_added_resale_aws_services => "VALUE_ADDED_RESALE_AWS_SERVICES",
            .training_services => "TRAINING_SERVICES",
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
