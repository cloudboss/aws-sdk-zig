const std = @import("std");

pub const ListBillEstimateLineItemsFilterName = enum {
    usage_account_id,
    service_code,
    usage_type,
    operation,
    location,
    line_item_type,

    pub const json_field_names = .{
        .usage_account_id = "USAGE_ACCOUNT_ID",
        .service_code = "SERVICE_CODE",
        .usage_type = "USAGE_TYPE",
        .operation = "OPERATION",
        .location = "LOCATION",
        .line_item_type = "LINE_ITEM_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .usage_account_id => "USAGE_ACCOUNT_ID",
            .service_code => "SERVICE_CODE",
            .usage_type => "USAGE_TYPE",
            .operation => "OPERATION",
            .location => "LOCATION",
            .line_item_type => "LINE_ITEM_TYPE",
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
