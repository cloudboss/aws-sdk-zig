pub const RouteResponseNoticeCode = enum {
    main_language_not_found,
    other,
    travel_time_exceeds_driver_work_hours,

    pub const json_field_names = .{
        .main_language_not_found = "MAIN_LANGUAGE_NOT_FOUND",
        .other = "OTHER",
        .travel_time_exceeds_driver_work_hours = "TRAVEL_TIME_EXCEEDS_DRIVER_WORK_HOURS",
    };
};
