const std = @import("std");

pub const UsageGroupByField = enum {
    queue_id,
    fleet_id,
    job_id,
    user_id,
    usage_type,
    instance_type,
    license_product,

    pub const json_field_names = .{
        .queue_id = "QUEUE_ID",
        .fleet_id = "FLEET_ID",
        .job_id = "JOB_ID",
        .user_id = "USER_ID",
        .usage_type = "USAGE_TYPE",
        .instance_type = "INSTANCE_TYPE",
        .license_product = "LICENSE_PRODUCT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queue_id => "QUEUE_ID",
            .fleet_id => "FLEET_ID",
            .job_id => "JOB_ID",
            .user_id => "USER_ID",
            .usage_type => "USAGE_TYPE",
            .instance_type => "INSTANCE_TYPE",
            .license_product => "LICENSE_PRODUCT",
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
