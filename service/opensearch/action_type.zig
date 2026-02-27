pub const ActionType = enum {
    service_software_update,
    jvm_heap_size_tuning,
    jvm_young_gen_tuning,

    pub const json_field_names = .{
        .service_software_update = "SERVICE_SOFTWARE_UPDATE",
        .jvm_heap_size_tuning = "JVM_HEAP_SIZE_TUNING",
        .jvm_young_gen_tuning = "JVM_YOUNG_GEN_TUNING",
    };
};
