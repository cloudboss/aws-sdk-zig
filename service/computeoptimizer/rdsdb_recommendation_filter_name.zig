const std = @import("std");

pub const RDSDBRecommendationFilterName = enum {
    instance_finding,
    instance_finding_reason_code,
    storage_finding,
    storage_finding_reason_code,
    idle,

    pub const json_field_names = .{
        .instance_finding = "InstanceFinding",
        .instance_finding_reason_code = "InstanceFindingReasonCode",
        .storage_finding = "StorageFinding",
        .storage_finding_reason_code = "StorageFindingReasonCode",
        .idle = "Idle",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_finding => "InstanceFinding",
            .instance_finding_reason_code => "InstanceFindingReasonCode",
            .storage_finding => "StorageFinding",
            .storage_finding_reason_code => "StorageFindingReasonCode",
            .idle => "Idle",
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
