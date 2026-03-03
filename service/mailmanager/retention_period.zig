const std = @import("std");

pub const RetentionPeriod = enum {
    three_months,
    six_months,
    nine_months,
    one_year,
    eighteen_months,
    two_years,
    thirty_months,
    three_years,
    four_years,
    five_years,
    six_years,
    seven_years,
    eight_years,
    nine_years,
    ten_years,
    permanent,

    pub const json_field_names = .{
        .three_months = "THREE_MONTHS",
        .six_months = "SIX_MONTHS",
        .nine_months = "NINE_MONTHS",
        .one_year = "ONE_YEAR",
        .eighteen_months = "EIGHTEEN_MONTHS",
        .two_years = "TWO_YEARS",
        .thirty_months = "THIRTY_MONTHS",
        .three_years = "THREE_YEARS",
        .four_years = "FOUR_YEARS",
        .five_years = "FIVE_YEARS",
        .six_years = "SIX_YEARS",
        .seven_years = "SEVEN_YEARS",
        .eight_years = "EIGHT_YEARS",
        .nine_years = "NINE_YEARS",
        .ten_years = "TEN_YEARS",
        .permanent = "PERMANENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .three_months => "THREE_MONTHS",
            .six_months => "SIX_MONTHS",
            .nine_months => "NINE_MONTHS",
            .one_year => "ONE_YEAR",
            .eighteen_months => "EIGHTEEN_MONTHS",
            .two_years => "TWO_YEARS",
            .thirty_months => "THIRTY_MONTHS",
            .three_years => "THREE_YEARS",
            .four_years => "FOUR_YEARS",
            .five_years => "FIVE_YEARS",
            .six_years => "SIX_YEARS",
            .seven_years => "SEVEN_YEARS",
            .eight_years => "EIGHT_YEARS",
            .nine_years => "NINE_YEARS",
            .ten_years => "TEN_YEARS",
            .permanent => "PERMANENT",
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
