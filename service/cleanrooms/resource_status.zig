const std = @import("std");

pub const ResourceStatus = enum {
    created,
    populate_started,
    populate_success,
    populate_failed,
    disallowed_by_data_provider,
    base_table_removed,
    retention_period_expired,

    pub const json_field_names = .{
        .created = "CREATED",
        .populate_started = "POPULATE_STARTED",
        .populate_success = "POPULATE_SUCCESS",
        .populate_failed = "POPULATE_FAILED",
        .disallowed_by_data_provider = "DISALLOWED_BY_DATA_PROVIDER",
        .base_table_removed = "BASE_TABLE_REMOVED",
        .retention_period_expired = "RETENTION_PERIOD_EXPIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .populate_started => "POPULATE_STARTED",
            .populate_success => "POPULATE_SUCCESS",
            .populate_failed => "POPULATE_FAILED",
            .disallowed_by_data_provider => "DISALLOWED_BY_DATA_PROVIDER",
            .base_table_removed => "BASE_TABLE_REMOVED",
            .retention_period_expired => "RETENTION_PERIOD_EXPIRED",
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
