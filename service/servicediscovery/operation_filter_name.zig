const std = @import("std");

pub const OperationFilterName = enum {
    namespace_id,
    service_id,
    status,
    @"type",
    update_date,

    pub const json_field_names = .{
        .namespace_id = "NAMESPACE_ID",
        .service_id = "SERVICE_ID",
        .status = "STATUS",
        .@"type" = "TYPE",
        .update_date = "UPDATE_DATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .namespace_id => "NAMESPACE_ID",
            .service_id => "SERVICE_ID",
            .status => "STATUS",
            .@"type" => "TYPE",
            .update_date => "UPDATE_DATE",
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
