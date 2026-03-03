const std = @import("std");

pub const TaskType = enum {
    evaluation,
    labeling_set_generation,
    import_labels,
    export_labels,
    find_matches,

    pub const json_field_names = .{
        .evaluation = "EVALUATION",
        .labeling_set_generation = "LABELING_SET_GENERATION",
        .import_labels = "IMPORT_LABELS",
        .export_labels = "EXPORT_LABELS",
        .find_matches = "FIND_MATCHES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .evaluation => "EVALUATION",
            .labeling_set_generation => "LABELING_SET_GENERATION",
            .import_labels => "IMPORT_LABELS",
            .export_labels => "EXPORT_LABELS",
            .find_matches => "FIND_MATCHES",
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
