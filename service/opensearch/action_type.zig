const std = @import("std");

pub const ActionType = enum {
    service_software_update,
    jvm_heap_size_tuning,
    jvm_young_gen_tuning,

    pub const json_field_names = .{
        .service_software_update = "SERVICE_SOFTWARE_UPDATE",
        .jvm_heap_size_tuning = "JVM_HEAP_SIZE_TUNING",
        .jvm_young_gen_tuning = "JVM_YOUNG_GEN_TUNING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_software_update => "SERVICE_SOFTWARE_UPDATE",
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
