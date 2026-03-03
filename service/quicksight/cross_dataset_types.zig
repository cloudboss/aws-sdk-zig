const std = @import("std");

pub const CrossDatasetTypes = enum {
    all_datasets,
    single_dataset,

    pub const json_field_names = .{
        .all_datasets = "ALL_DATASETS",
        .single_dataset = "SINGLE_DATASET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_datasets => "ALL_DATASETS",
            .single_dataset => "SINGLE_DATASET",
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
