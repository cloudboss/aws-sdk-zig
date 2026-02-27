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
};
