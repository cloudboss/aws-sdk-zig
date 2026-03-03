const std = @import("std");

/// The type of field. The valid options for a field depend on the field type.
/// For more information about the supported field types, see [Configuring Index
/// Fields](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-index-fields.html) in the *Amazon CloudSearch Developer Guide*.
pub const IndexFieldType = enum {
    int,
    double,
    literal,
    text,
    date,
    latlon,
    int_array,
    double_array,
    literal_array,
    text_array,
    date_array,

    pub const json_field_names = .{
        .int = "int",
        .double = "double",
        .literal = "literal",
        .text = "text",
        .date = "date",
        .latlon = "latlon",
        .int_array = "int-array",
        .double_array = "double-array",
        .literal_array = "literal-array",
        .text_array = "text-array",
        .date_array = "date-array",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .int => "int",
            .double => "double",
            .literal => "literal",
            .text => "text",
            .date => "date",
            .latlon => "latlon",
            .int_array => "int-array",
            .double_array => "double-array",
            .literal_array => "literal-array",
            .text_array => "text-array",
            .date_array => "date-array",
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
