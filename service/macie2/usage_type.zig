const std = @import("std");

/// The name of an Amazon Macie usage metric for an account. Possible values
/// are:
pub const UsageType = enum {
    data_inventory_evaluation,
    sensitive_data_discovery,
    automated_sensitive_data_discovery,
    automated_object_monitoring,

    pub const json_field_names = .{
        .data_inventory_evaluation = "DATA_INVENTORY_EVALUATION",
        .sensitive_data_discovery = "SENSITIVE_DATA_DISCOVERY",
        .automated_sensitive_data_discovery = "AUTOMATED_SENSITIVE_DATA_DISCOVERY",
        .automated_object_monitoring = "AUTOMATED_OBJECT_MONITORING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data_inventory_evaluation => "DATA_INVENTORY_EVALUATION",
            .sensitive_data_discovery => "SENSITIVE_DATA_DISCOVERY",
            .automated_sensitive_data_discovery => "AUTOMATED_SENSITIVE_DATA_DISCOVERY",
            .automated_object_monitoring => "AUTOMATED_OBJECT_MONITORING",
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
