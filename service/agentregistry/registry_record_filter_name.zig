const std = @import("std");

/// The attribute to filter registry records on.
pub const RegistryRecordFilterName = enum {
    /// Filters records by record type, such as `MCP` or `AGENT`.
    record_type,
    descriptor_type,

    pub const json_field_names = .{
        .record_type = "recordType",
        .descriptor_type = "descriptorType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .record_type => "recordType",
            .descriptor_type => "descriptorType",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
