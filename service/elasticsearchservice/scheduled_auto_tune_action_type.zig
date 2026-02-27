/// Specifies Auto-Tune action type. Valid values are JVM_HEAP_SIZE_TUNING and
/// JVM_YOUNG_GEN_TUNING.
pub const ScheduledAutoTuneActionType = enum {
    jvm_heap_size_tuning,
    jvm_young_gen_tuning,

    pub const json_field_names = .{
        .jvm_heap_size_tuning = "JVM_HEAP_SIZE_TUNING",
        .jvm_young_gen_tuning = "JVM_YOUNG_GEN_TUNING",
    };
};
