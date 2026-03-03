const PrimaryValueResponse = @import("primary_value_response.zig").PrimaryValueResponse;

/// A record primary value.
pub const RecordPrimaryValue = struct {
    /// The value's last modified region.
    last_modified_region: ?[]const u8 = null,

    /// The value's last modified time.
    last_modified_time: ?i64 = null,

    /// The value's primary values.
    primary_values: ?[]const PrimaryValueResponse = null,

    /// The value's record ID.
    record_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .primary_values = "PrimaryValues",
        .record_id = "RecordId",
    };
};
