const std = @import("std");

pub const ServerCriteria = enum {
    not_defined,
    os_name,
    strategy,
    destination,
    server_id,
    analysis_status,
    error_category,

    pub const json_field_names = .{
        .not_defined = "NOT_DEFINED",
        .os_name = "OS_NAME",
        .strategy = "STRATEGY",
        .destination = "DESTINATION",
        .server_id = "SERVER_ID",
        .analysis_status = "ANALYSIS_STATUS",
        .error_category = "ERROR_CATEGORY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_defined => "NOT_DEFINED",
            .os_name => "OS_NAME",
            .strategy => "STRATEGY",
            .destination => "DESTINATION",
            .server_id => "SERVER_ID",
            .analysis_status => "ANALYSIS_STATUS",
            .error_category => "ERROR_CATEGORY",
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
