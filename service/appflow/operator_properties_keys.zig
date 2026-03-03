const std = @import("std");

pub const OperatorPropertiesKeys = enum {
    value,
    values,
    data_type,
    upper_bound,
    lower_bound,
    source_data_type,
    destination_data_type,
    validation_action,
    mask_value,
    mask_length,
    truncate_length,
    math_operation_fields_order,
    concat_format,
    subfield_category_map,
    exclude_source_fields_list,
    include_new_fields,
    ordered_partition_keys_list,

    pub const json_field_names = .{
        .value = "VALUE",
        .values = "VALUES",
        .data_type = "DATA_TYPE",
        .upper_bound = "UPPER_BOUND",
        .lower_bound = "LOWER_BOUND",
        .source_data_type = "SOURCE_DATA_TYPE",
        .destination_data_type = "DESTINATION_DATA_TYPE",
        .validation_action = "VALIDATION_ACTION",
        .mask_value = "MASK_VALUE",
        .mask_length = "MASK_LENGTH",
        .truncate_length = "TRUNCATE_LENGTH",
        .math_operation_fields_order = "MATH_OPERATION_FIELDS_ORDER",
        .concat_format = "CONCAT_FORMAT",
        .subfield_category_map = "SUBFIELD_CATEGORY_MAP",
        .exclude_source_fields_list = "EXCLUDE_SOURCE_FIELDS_LIST",
        .include_new_fields = "INCLUDE_NEW_FIELDS",
        .ordered_partition_keys_list = "ORDERED_PARTITION_KEYS_LIST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .value => "VALUE",
            .values => "VALUES",
            .data_type => "DATA_TYPE",
            .upper_bound => "UPPER_BOUND",
            .lower_bound => "LOWER_BOUND",
            .source_data_type => "SOURCE_DATA_TYPE",
            .destination_data_type => "DESTINATION_DATA_TYPE",
            .validation_action => "VALIDATION_ACTION",
            .mask_value => "MASK_VALUE",
            .mask_length => "MASK_LENGTH",
            .truncate_length => "TRUNCATE_LENGTH",
            .math_operation_fields_order => "MATH_OPERATION_FIELDS_ORDER",
            .concat_format => "CONCAT_FORMAT",
            .subfield_category_map => "SUBFIELD_CATEGORY_MAP",
            .exclude_source_fields_list => "EXCLUDE_SOURCE_FIELDS_LIST",
            .include_new_fields => "INCLUDE_NEW_FIELDS",
            .ordered_partition_keys_list => "ORDERED_PARTITION_KEYS_LIST",
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
