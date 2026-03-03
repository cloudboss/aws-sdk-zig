const std = @import("std");

/// A page type as defined in the standard ETSI EN 300 468, Table 94
pub const TeletextPageType = enum {
    page_type_initial,
    page_type_subtitle,
    page_type_addl_info,
    page_type_program_schedule,
    page_type_hearing_impaired_subtitle,

    pub const json_field_names = .{
        .page_type_initial = "PAGE_TYPE_INITIAL",
        .page_type_subtitle = "PAGE_TYPE_SUBTITLE",
        .page_type_addl_info = "PAGE_TYPE_ADDL_INFO",
        .page_type_program_schedule = "PAGE_TYPE_PROGRAM_SCHEDULE",
        .page_type_hearing_impaired_subtitle = "PAGE_TYPE_HEARING_IMPAIRED_SUBTITLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .page_type_initial => "PAGE_TYPE_INITIAL",
            .page_type_subtitle => "PAGE_TYPE_SUBTITLE",
            .page_type_addl_info => "PAGE_TYPE_ADDL_INFO",
            .page_type_program_schedule => "PAGE_TYPE_PROGRAM_SCHEDULE",
            .page_type_hearing_impaired_subtitle => "PAGE_TYPE_HEARING_IMPAIRED_SUBTITLE",
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
