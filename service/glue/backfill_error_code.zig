const std = @import("std");

pub const BackfillErrorCode = enum {
    encrypted_partition_error,
    internal_error,
    invalid_partition_type_data_error,
    missing_partition_value_error,
    unsupported_partition_character_error,

    pub const json_field_names = .{
        .encrypted_partition_error = "ENCRYPTED_PARTITION_ERROR",
        .internal_error = "INTERNAL_ERROR",
        .invalid_partition_type_data_error = "INVALID_PARTITION_TYPE_DATA_ERROR",
        .missing_partition_value_error = "MISSING_PARTITION_VALUE_ERROR",
        .unsupported_partition_character_error = "UNSUPPORTED_PARTITION_CHARACTER_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .encrypted_partition_error => "ENCRYPTED_PARTITION_ERROR",
            .internal_error => "INTERNAL_ERROR",
            .invalid_partition_type_data_error => "INVALID_PARTITION_TYPE_DATA_ERROR",
            .missing_partition_value_error => "MISSING_PARTITION_VALUE_ERROR",
            .unsupported_partition_character_error => "UNSUPPORTED_PARTITION_CHARACTER_ERROR",
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
