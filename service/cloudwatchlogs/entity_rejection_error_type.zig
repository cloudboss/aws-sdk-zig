const std = @import("std");

pub const EntityRejectionErrorType = enum {
    invalid_entity,
    invalid_type_value,
    invalid_key_attribute,
    invalid_attributes,
    entity_size_too_large,
    unsupported_log_group_type,
    missing_required_fields,

    pub const json_field_names = .{
        .invalid_entity = "InvalidEntity",
        .invalid_type_value = "InvalidTypeValue",
        .invalid_key_attribute = "InvalidKeyAttributes",
        .invalid_attributes = "InvalidAttributes",
        .entity_size_too_large = "EntitySizeTooLarge",
        .unsupported_log_group_type = "UnsupportedLogGroupType",
        .missing_required_fields = "MissingRequiredFields",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_entity => "InvalidEntity",
            .invalid_type_value => "InvalidTypeValue",
            .invalid_key_attribute => "InvalidKeyAttributes",
            .invalid_attributes => "InvalidAttributes",
            .entity_size_too_large => "EntitySizeTooLarge",
            .unsupported_log_group_type => "UnsupportedLogGroupType",
            .missing_required_fields => "MissingRequiredFields",
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
