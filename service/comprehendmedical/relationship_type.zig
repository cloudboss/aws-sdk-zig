const std = @import("std");

pub const RelationshipType = enum {
    every,
    with_dosage,
    administered_via,
    @"for",
    negative,
    overlap,
    dosage,
    route_or_mode,
    form,
    frequency,
    duration,
    strength,
    rate,
    acuity,
    test_value,
    test_units,
    test_unit,
    direction,
    system_organ_site,
    amount,
    usage,
    quality,

    pub const json_field_names = .{
        .every = "EVERY",
        .with_dosage = "WITH_DOSAGE",
        .administered_via = "ADMINISTERED_VIA",
        .@"for" = "FOR",
        .negative = "NEGATIVE",
        .overlap = "OVERLAP",
        .dosage = "DOSAGE",
        .route_or_mode = "ROUTE_OR_MODE",
        .form = "FORM",
        .frequency = "FREQUENCY",
        .duration = "DURATION",
        .strength = "STRENGTH",
        .rate = "RATE",
        .acuity = "ACUITY",
        .test_value = "TEST_VALUE",
        .test_units = "TEST_UNITS",
        .test_unit = "TEST_UNIT",
        .direction = "DIRECTION",
        .system_organ_site = "SYSTEM_ORGAN_SITE",
        .amount = "AMOUNT",
        .usage = "USAGE",
        .quality = "QUALITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .every => "EVERY",
            .with_dosage => "WITH_DOSAGE",
            .administered_via => "ADMINISTERED_VIA",
            .@"for" => "FOR",
            .negative => "NEGATIVE",
            .overlap => "OVERLAP",
            .dosage => "DOSAGE",
            .route_or_mode => "ROUTE_OR_MODE",
            .form => "FORM",
            .frequency => "FREQUENCY",
            .duration => "DURATION",
            .strength => "STRENGTH",
            .rate => "RATE",
            .acuity => "ACUITY",
            .test_value => "TEST_VALUE",
            .test_units => "TEST_UNITS",
            .test_unit => "TEST_UNIT",
            .direction => "DIRECTION",
            .system_organ_site => "SYSTEM_ORGAN_SITE",
            .amount => "AMOUNT",
            .usage => "USAGE",
            .quality => "QUALITY",
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
