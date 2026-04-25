const std = @import("std");

pub const ValidationExceptionReason = enum {
    invalid_agreement_id,
    missing_agreement_id,
    invalid_catalog,
    invalid_filter_name,
    invalid_filter_values,
    invalid_sort_by,
    invalid_sort_order,
    invalid_next_token,
    invalid_max_results,
    invalid_term_id,
    missing_term_id,
    missing_name,
    invalid_name,
    invalid_description,
    missing_charge_amount,
    invalid_charge_amount,
    missing_payment_request_id,
    invalid_payment_request_id,
    missing_party_type,
    invalid_party_type,
    unsupported_filters,
    invalid_rejection_reason,
    invalid_payment_request_status,
    other,

    pub const json_field_names = .{
        .invalid_agreement_id = "INVALID_AGREEMENT_ID",
        .missing_agreement_id = "MISSING_AGREEMENT_ID",
        .invalid_catalog = "INVALID_CATALOG",
        .invalid_filter_name = "INVALID_FILTER_NAME",
        .invalid_filter_values = "INVALID_FILTER_VALUES",
        .invalid_sort_by = "INVALID_SORT_BY",
        .invalid_sort_order = "INVALID_SORT_ORDER",
        .invalid_next_token = "INVALID_NEXT_TOKEN",
        .invalid_max_results = "INVALID_MAX_RESULTS",
        .invalid_term_id = "INVALID_TERM_ID",
        .missing_term_id = "MISSING_TERM_ID",
        .missing_name = "MISSING_NAME",
        .invalid_name = "INVALID_NAME",
        .invalid_description = "INVALID_DESCRIPTION",
        .missing_charge_amount = "MISSING_CHARGE_AMOUNT",
        .invalid_charge_amount = "INVALID_CHARGE_AMOUNT",
        .missing_payment_request_id = "MISSING_PAYMENT_REQUEST_ID",
        .invalid_payment_request_id = "INVALID_PAYMENT_REQUEST_ID",
        .missing_party_type = "MISSING_PARTY_TYPE",
        .invalid_party_type = "INVALID_PARTY_TYPE",
        .unsupported_filters = "UNSUPPORTED_FILTERS",
        .invalid_rejection_reason = "INVALID_REJECTION_REASON",
        .invalid_payment_request_status = "INVALID_PAYMENT_REQUEST_STATUS",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_agreement_id => "INVALID_AGREEMENT_ID",
            .missing_agreement_id => "MISSING_AGREEMENT_ID",
            .invalid_catalog => "INVALID_CATALOG",
            .invalid_filter_name => "INVALID_FILTER_NAME",
            .invalid_filter_values => "INVALID_FILTER_VALUES",
            .invalid_sort_by => "INVALID_SORT_BY",
            .invalid_sort_order => "INVALID_SORT_ORDER",
            .invalid_next_token => "INVALID_NEXT_TOKEN",
            .invalid_max_results => "INVALID_MAX_RESULTS",
            .invalid_term_id => "INVALID_TERM_ID",
            .missing_term_id => "MISSING_TERM_ID",
            .missing_name => "MISSING_NAME",
            .invalid_name => "INVALID_NAME",
            .invalid_description => "INVALID_DESCRIPTION",
            .missing_charge_amount => "MISSING_CHARGE_AMOUNT",
            .invalid_charge_amount => "INVALID_CHARGE_AMOUNT",
            .missing_payment_request_id => "MISSING_PAYMENT_REQUEST_ID",
            .invalid_payment_request_id => "INVALID_PAYMENT_REQUEST_ID",
            .missing_party_type => "MISSING_PARTY_TYPE",
            .invalid_party_type => "INVALID_PARTY_TYPE",
            .unsupported_filters => "UNSUPPORTED_FILTERS",
            .invalid_rejection_reason => "INVALID_REJECTION_REASON",
            .invalid_payment_request_status => "INVALID_PAYMENT_REQUEST_STATUS",
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
