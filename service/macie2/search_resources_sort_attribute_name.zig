const std = @import("std");

/// The property to sort the query results by. Valid values are:
pub const SearchResourcesSortAttributeName = enum {
    account_id,
    resource_name,
    s3_classifiable_object_count,
    s3_classifiable_size_in_bytes,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .resource_name = "RESOURCE_NAME",
        .s3_classifiable_object_count = "S3_CLASSIFIABLE_OBJECT_COUNT",
        .s3_classifiable_size_in_bytes = "S3_CLASSIFIABLE_SIZE_IN_BYTES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "ACCOUNT_ID",
            .resource_name => "RESOURCE_NAME",
            .s3_classifiable_object_count => "S3_CLASSIFIABLE_OBJECT_COUNT",
            .s3_classifiable_size_in_bytes => "S3_CLASSIFIABLE_SIZE_IN_BYTES",
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
