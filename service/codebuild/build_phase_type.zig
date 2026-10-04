const std = @import("std");

pub const BuildPhaseType = enum {
    submitted,
    queued,
    provisioning,
    download_source,
    install,
    pre_build,
    build,
    post_build,
    upload_artifacts,
    finalizing,
    completed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .queued = "QUEUED",
        .provisioning = "PROVISIONING",
        .download_source = "DOWNLOAD_SOURCE",
        .install = "INSTALL",
        .pre_build = "PRE_BUILD",
        .build = "BUILD",
        .post_build = "POST_BUILD",
        .upload_artifacts = "UPLOAD_ARTIFACTS",
        .finalizing = "FINALIZING",
        .completed = "COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .queued => "QUEUED",
            .provisioning => "PROVISIONING",
            .download_source => "DOWNLOAD_SOURCE",
            .install => "INSTALL",
            .pre_build => "PRE_BUILD",
            .build => "BUILD",
            .post_build => "POST_BUILD",
            .upload_artifacts => "UPLOAD_ARTIFACTS",
            .finalizing => "FINALIZING",
            .completed => "COMPLETED",
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
