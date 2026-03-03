const std = @import("std");

pub const IcebergUpdateAction = enum {
    add_schema,
    set_current_schema,
    add_spec,
    set_default_spec,
    add_sort_order,
    set_default_sort_order,
    set_location,
    set_properties,
    remove_properties,
    add_encryption_key,
    remove_encryption_key,

    pub const json_field_names = .{
        .add_schema = "add-schema",
        .set_current_schema = "set-current-schema",
        .add_spec = "add-spec",
        .set_default_spec = "set-default-spec",
        .add_sort_order = "add-sort-order",
        .set_default_sort_order = "set-default-sort-order",
        .set_location = "set-location",
        .set_properties = "set-properties",
        .remove_properties = "remove-properties",
        .add_encryption_key = "add-encryption-key",
        .remove_encryption_key = "remove-encryption-key",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .add_schema => "add-schema",
            .set_current_schema => "set-current-schema",
            .add_spec => "add-spec",
            .set_default_spec => "set-default-spec",
            .add_sort_order => "add-sort-order",
            .set_default_sort_order => "set-default-sort-order",
            .set_location => "set-location",
            .set_properties => "set-properties",
            .remove_properties => "remove-properties",
            .add_encryption_key => "add-encryption-key",
            .remove_encryption_key => "remove-encryption-key",
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
