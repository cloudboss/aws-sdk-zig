const std = @import("std");

pub const OrderingRequirementType = enum {
    outpost_active_check_error,
    maximum_allowed_orders_check_error,
    valid_zip_code_check_error,
    rack_physical_properties_check_error,
    operating_address_existence_check_error,
    shipping_address_existence_check_error,
    country_code_mismatch_check_error,
    outpost_generation_mismatch_error,
    unsupported,
    outpost_id_missing_on_quote_error,
    enterprise_support_error,
    shipping_address_missing_contact_name_error,
    shipping_address_missing_contact_number_error,
    shipping_address_missing_contact_info_error,
    outpost_state_changed_error,
    outpost_not_found_error,
    outpost_renewal_required_error,

    pub const json_field_names = .{
        .outpost_active_check_error = "OUTPOST_ACTIVE_CHECK_ERROR",
        .maximum_allowed_orders_check_error = "MAXIMUM_ALLOWED_ORDERS_CHECK_ERROR",
        .valid_zip_code_check_error = "VALID_ZIP_CODE_CHECK_ERROR",
        .rack_physical_properties_check_error = "RACK_PHYSICAL_PROPERTIES_CHECK_ERROR",
        .operating_address_existence_check_error = "OPERATING_ADDRESS_EXISTENCE_CHECK_ERROR",
        .shipping_address_existence_check_error = "SHIPPING_ADDRESS_EXISTENCE_CHECK_ERROR",
        .country_code_mismatch_check_error = "COUNTRY_CODE_MISMATCH_CHECK_ERROR",
        .outpost_generation_mismatch_error = "OUTPOST_GENERATION_MISMATCH_ERROR",
        .unsupported = "UNSUPPORTED",
        .outpost_id_missing_on_quote_error = "OUTPOST_ID_MISSING_ON_QUOTE_ERROR",
        .enterprise_support_error = "ENTERPRISE_SUPPORT_ERROR",
        .shipping_address_missing_contact_name_error = "SHIPPING_ADDRESS_MISSING_CONTACT_NAME_ERROR",
        .shipping_address_missing_contact_number_error = "SHIPPING_ADDRESS_MISSING_CONTACT_NUMBER_ERROR",
        .shipping_address_missing_contact_info_error = "SHIPPING_ADDRESS_MISSING_CONTACT_INFO_ERROR",
        .outpost_state_changed_error = "OUTPOST_STATE_CHANGED_ERROR",
        .outpost_not_found_error = "OUTPOST_NOT_FOUND_ERROR",
        .outpost_renewal_required_error = "OUTPOST_RENEWAL_REQUIRED_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .outpost_active_check_error => "OUTPOST_ACTIVE_CHECK_ERROR",
            .maximum_allowed_orders_check_error => "MAXIMUM_ALLOWED_ORDERS_CHECK_ERROR",
            .valid_zip_code_check_error => "VALID_ZIP_CODE_CHECK_ERROR",
            .rack_physical_properties_check_error => "RACK_PHYSICAL_PROPERTIES_CHECK_ERROR",
            .operating_address_existence_check_error => "OPERATING_ADDRESS_EXISTENCE_CHECK_ERROR",
            .shipping_address_existence_check_error => "SHIPPING_ADDRESS_EXISTENCE_CHECK_ERROR",
            .country_code_mismatch_check_error => "COUNTRY_CODE_MISMATCH_CHECK_ERROR",
            .outpost_generation_mismatch_error => "OUTPOST_GENERATION_MISMATCH_ERROR",
            .unsupported => "UNSUPPORTED",
            .outpost_id_missing_on_quote_error => "OUTPOST_ID_MISSING_ON_QUOTE_ERROR",
            .enterprise_support_error => "ENTERPRISE_SUPPORT_ERROR",
            .shipping_address_missing_contact_name_error => "SHIPPING_ADDRESS_MISSING_CONTACT_NAME_ERROR",
            .shipping_address_missing_contact_number_error => "SHIPPING_ADDRESS_MISSING_CONTACT_NUMBER_ERROR",
            .shipping_address_missing_contact_info_error => "SHIPPING_ADDRESS_MISSING_CONTACT_INFO_ERROR",
            .outpost_state_changed_error => "OUTPOST_STATE_CHANGED_ERROR",
            .outpost_not_found_error => "OUTPOST_NOT_FOUND_ERROR",
            .outpost_renewal_required_error => "OUTPOST_RENEWAL_REQUIRED_ERROR",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
