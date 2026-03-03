const std = @import("std");

pub const GroupBy = enum {
    resources_affected_s_3_bucket_name,
    @"type",
    classification_details_job_id,
    severity_description,

    pub const json_field_names = .{
        .resources_affected_s_3_bucket_name = "resourcesAffected.s3Bucket.name",
        .@"type" = "type",
        .classification_details_job_id = "classificationDetails.jobId",
        .severity_description = "severity.description",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resources_affected_s_3_bucket_name => "resourcesAffected.s3Bucket.name",
            .@"type" => "type",
            .classification_details_job_id => "classificationDetails.jobId",
            .severity_description => "severity.description",
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
