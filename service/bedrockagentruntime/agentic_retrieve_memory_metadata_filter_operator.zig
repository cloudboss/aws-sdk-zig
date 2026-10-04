const std = @import("std");

/// Specifies the relationship that a metadata key and value must have for a
/// memory record to match a filter expression.
pub const AgenticRetrieveMemoryMetadataFilterOperator = enum {
    /// The EQUALS_TO operator matches memory records whose metadata value equals
    /// the supplied value.
    equals_to,
    /// The EXISTS operator matches memory records that carry the metadata key,
    /// whatever its value. This operator takes no right operand.
    exists,
    /// The NOT_EXISTS operator matches memory records that do not carry the
    /// metadata key. This operator takes no right operand.
    not_exists,
    /// The BEFORE operator matches memory records whose timestamp metadata value
    /// falls before the supplied value.
    before,
    /// The AFTER operator matches memory records whose timestamp metadata value
    /// falls after the supplied value.
    after,
    /// The CONTAINS operator matches memory records whose metadata value contains
    /// the supplied value.
    contains,
    /// The GREATER_THAN operator matches memory records whose numeric metadata
    /// value is greater than the supplied value.
    greater_than,
    /// The GREATER_THAN_OR_EQUALS operator matches memory records whose numeric
    /// metadata value is greater than or equal to the supplied value.
    greater_than_or_equals,
    /// The LESS_THAN operator matches memory records whose numeric metadata value
    /// is less than the supplied value.
    less_than,
    /// The LESS_THAN_OR_EQUALS operator matches memory records whose numeric
    /// metadata value is less than or equal to the supplied value.
    less_than_or_equals,

    pub const json_field_names = .{
        .equals_to = "EQUALS_TO",
        .exists = "EXISTS",
        .not_exists = "NOT_EXISTS",
        .before = "BEFORE",
        .after = "AFTER",
        .contains = "CONTAINS",
        .greater_than = "GREATER_THAN",
        .greater_than_or_equals = "GREATER_THAN_OR_EQUALS",
        .less_than = "LESS_THAN",
        .less_than_or_equals = "LESS_THAN_OR_EQUALS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals_to => "EQUALS_TO",
            .exists => "EXISTS",
            .not_exists => "NOT_EXISTS",
            .before => "BEFORE",
            .after => "AFTER",
            .contains => "CONTAINS",
            .greater_than => "GREATER_THAN",
            .greater_than_or_equals => "GREATER_THAN_OR_EQUALS",
            .less_than => "LESS_THAN",
            .less_than_or_equals => "LESS_THAN_OR_EQUALS",
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
