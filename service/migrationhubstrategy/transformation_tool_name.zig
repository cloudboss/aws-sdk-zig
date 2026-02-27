pub const TransformationToolName = enum {
    app2_container,
    porting_assistant,
    emp,
    wwama,
    mgn,
    strategy_recommendation_support,
    in_place_os_upgrade,
    sct,
    dms,
    native_sql,

    pub const json_field_names = .{
        .app2_container = "APP2CONTAINER",
        .porting_assistant = "PORTING_ASSISTANT",
        .emp = "EMP",
        .wwama = "WWAMA",
        .mgn = "MGN",
        .strategy_recommendation_support = "STRATEGY_RECOMMENDATION_SUPPORT",
        .in_place_os_upgrade = "IN_PLACE_OS_UPGRADE",
        .sct = "SCT",
        .dms = "DMS",
        .native_sql = "NATIVE_SQL",
    };
};
