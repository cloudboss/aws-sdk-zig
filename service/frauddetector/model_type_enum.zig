const std = @import("std");

pub const ModelTypeEnum = enum {
    online_fraud_insights,
    transaction_fraud_insights,
    account_takeover_insights,

    pub const json_field_names = .{
        .online_fraud_insights = "ONLINE_FRAUD_INSIGHTS",
        .transaction_fraud_insights = "TRANSACTION_FRAUD_INSIGHTS",
        .account_takeover_insights = "ACCOUNT_TAKEOVER_INSIGHTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .online_fraud_insights => "ONLINE_FRAUD_INSIGHTS",
            .transaction_fraud_insights => "TRANSACTION_FRAUD_INSIGHTS",
            .account_takeover_insights => "ACCOUNT_TAKEOVER_INSIGHTS",
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
