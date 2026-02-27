pub const PredicateType = enum {
    ip_match,
    byte_match,
    sql_injection_match,
    geo_match,
    size_constraint,
    xss_match,
    regex_match,

    pub const json_field_names = .{
        .ip_match = "IP_MATCH",
        .byte_match = "BYTE_MATCH",
        .sql_injection_match = "SQL_INJECTION_MATCH",
        .geo_match = "GEO_MATCH",
        .size_constraint = "SIZE_CONSTRAINT",
        .xss_match = "XSS_MATCH",
        .regex_match = "REGEX_MATCH",
    };
};
