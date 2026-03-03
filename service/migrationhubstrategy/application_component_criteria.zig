const std = @import("std");

pub const ApplicationComponentCriteria = enum {
    not_defined,
    app_name,
    server_id,
    app_type,
    strategy,
    destination,
    analysis_status,
    error_category,

    pub const json_field_names = .{
        .not_defined = "NOT_DEFINED",
        .app_name = "APP_NAME",
        .server_id = "SERVER_ID",
        .app_type = "APP_TYPE",
        .strategy = "STRATEGY",
        .destination = "DESTINATION",
        .analysis_status = "ANALYSIS_STATUS",
        .error_category = "ERROR_CATEGORY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_defined => "NOT_DEFINED",
            .app_name => "APP_NAME",
            .server_id => "SERVER_ID",
            .app_type => "APP_TYPE",
            .strategy => "STRATEGY",
            .destination => "DESTINATION",
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
