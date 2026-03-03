const std = @import("std");

/// The Auto-Tune action type.
pub const ScheduledAutoTuneActionType = enum {
    jvm_heap_size_tuning,
    jvm_young_gen_tuning,

    pub const json_field_names = .{
        .jvm_heap_size_tuning = "JVM_HEAP_SIZE_TUNING",
        .jvm_young_gen_tuning = "JVM_YOUNG_GEN_TUNING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .jvm_heap_size_tuning => "JVM_HEAP_SIZE_TUNING",
            .jvm_young_gen_tuning => "JVM_YOUNG_GEN_TUNING",
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
