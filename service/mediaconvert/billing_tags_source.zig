const std = @import("std");

/// The tag type that AWS Billing and Cost Management will use to sort your AWS
/// Elemental MediaConvert costs on any billing report that you set up.
pub const BillingTagsSource = enum {
    queue,
    preset,
    job_template,
    job,

    pub const json_field_names = .{
        .queue = "QUEUE",
        .preset = "PRESET",
        .job_template = "JOB_TEMPLATE",
        .job = "JOB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queue => "QUEUE",
            .preset => "PRESET",
            .job_template => "JOB_TEMPLATE",
            .job => "JOB",
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
